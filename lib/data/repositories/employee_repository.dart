import 'dart:convert';
import 'package:BTechApp_Final_Project/data/models/checkin_model.dart';
import 'package:BTechApp_Final_Project/data/models/employee_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EmployeeRepository {
  static const String employeeTableName = 'Employees';
  static const String checkInTableName = 'CheckIn';
  static const String checkOutTableName = 'CheckOut';
  static const String attendanceTableName = 'Attendance';
  static const String estateTableName = 'Estate';
  static const String divisionTableName = 'Division';
  static const String kemandoranTableName = 'Kemandoran';
  static const String assistanceOutTableName = 'AssistanceOut';

  Future<Database> open() async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, 'Employee_database.db');

    return openDatabase(
      databasePath,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS $employeeTableName(
          
          nik TEXT PRIMARY KEY,
          name TEXT,
          age INTEGER,
          position TEXT,
          division TEXT,
          kemandoran TEXT
          
        )
      ''');

        db.execute('''
        CREATE TABLE IF NOT EXISTS $checkInTableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nik TEXT,
          name TEXT,
          isCheckedIn INTEGER,
          checkInTime TEXT,
          isLated INTEGER,
          FOREIGN KEY (nik) REFERENCES Employees(nik)
        )
      ''');

        db.execute('''
         CREATE TABLE IF NOT EXISTS $checkOutTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nik TEXT,
            name TEXT,
            isCheckedOut INTEGER,
            checkoutTime TEXT,
            isLated INTEGER,
            note TEXT,
            FOREIGN KEY (nik) REFERENCES Employees(nik)
            )
      ''');

        db.execute('''
         CREATE TABLE IF NOT EXISTS $attendanceTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nik TEXT,
            name TEXT,
            idCheckIn INTEGER,
            idCheckOut INTEGER,
            isCheckedIn INTEGER,
            checkinTime TEXT,
            isCheckedOut INTEGER,
            checkoutTime TEXT
            note TEXT,
            cretedAt TEXT,
            FOREIGN KEY (nik) REFERENCES Employees(nik),
            FOREIGN KEY (idCheckIn) REFERENCES CheckIn(id),
            FOREIGN KEY (idCheckOut) REFERENCES CheckOut(id)
            )
      ''');

        db.execute('''
          CREATE TABLE IF NOT EXISTS $estateTableName(
            id_estate TEXT PRIMARY KEY,
            estate TEXT
          )
        ''');

        db.execute('''
          CREATE TABLE IF NOT EXISTS $divisionTableName(
            id_division TEXT PRIMARY KEY,
            division TEXT,
            id_estate TEXT,
            FOREIGN KEY (id_estate) REFERENCES $estateTableName(id_estate)
          )
        ''');
        db.execute('''
          CREATE TABLE IF NOT EXISTS $kemandoranTableName(
            id_kemandoran TEXT PRIMARY KEY,
            id_division TEXT,
            id_estate TEXT,
            kemandoran TEXT,
            groupName TEXT,
            FOREIGN KEY (id_division) REFERENCES $divisionTableName(id_division),
            FOREIGN KEY (id_estate) REFERENCES $estateTableName(id_estate)
          )
        ''');

        db.execute('''
        CREATE TABLE IF NOT EXISTS $assistanceOutTableName(
    id_assistance INTEGER PRIMARY KEY AUTOINCREMENT,
    assistance_type TEXT,
    employee_nik TEXT,
    employee_name TEXT,
    employee_age INTEGER,
    employee_position TEXT,
    division TEXT,
    kemandoran TEXT,
    estate TEXT,
    assistanceOutTime TEXT,
    FOREIGN KEY (employee_nik) REFERENCES $employeeTableName(nik),
    FOREIGN KEY (division) REFERENCES $divisionTableName(id_division),
    FOREIGN KEY (kemandoran) REFERENCES $kemandoranTableName(id_kemandoran),
    FOREIGN KEY (estate) REFERENCES $estateTableName(id_estate)
  )
''');
      },
      version: 12,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          if (oldVersion < 13) {
            await _upgradeDatabase(db, oldVersion, newVersion);
          }
        }
      },
    );
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (oldVersion < 13) {
        await db.transaction((txn) async {
          await txn.execute('BEGIN TRANSACTION;');
          await txn.execute(
              'CREATE TABLE Employees_temp AS SELECT * FROM Employees;');
          await txn.execute('DROP TABLE Employees;');
          await txn.execute(
              'CREATE TABLE Employees (nik TEXT PRIMARY KEY, name TEXT, age INTEGER, position TEXT, division TEXT, kemandoran TEXT);');
          await txn.execute(
              'INSERT INTO Employees (nik, name, age, position, division, kemandoran, isCheckedIn, isCheckedOut, checkin_time) SELECT nik, name, age, position, division, kemandoran, isCheckedIn, isCheckedOut, checkin_time FROM Employees_temp;');
          await txn.execute('DROP TABLE Employees_temp;');
          await txn.execute('COMMIT;');
        });
      }
    }
  }

  Future<Map<String, dynamic>?> findEmployeeByNik(
      String nik, String name) async {
    final Database db = await open();
    final List<Map<String, dynamic>> maps = await db.query(
      EmployeeRepository.employeeTableName,
      where: "nik = ? AND name = ?",
      whereArgs: [nik, name],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<void> injectFromJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/employee_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<Employee> employees =
        jsonList.map((e) => Employee.fromJson(e)).toList();

    final Database db = await open();

    try {
      for (final employee in employees) {
        final existingEmployee =
            await findEmployeeByNik(employee.nik, employee.name);
        if (existingEmployee == null) {
          await insertEmployee(employee);
        } else {
          employee.nik = existingEmployee['nik'];
          employee.name = existingEmployee['name'];
          await update(employee);
        }
      }
    } finally {
      db.close(); // Tutup objek Database
    }
  }

  Future<CheckInModel> insertCheckIn(String nik, String name, int isCheckedIn, String checkInTime) async {
    final db = await open();
    final checkIn = CheckInModel(
      nik: nik,
      name: name,
      isCheckedIn: isCheckedIn,
      checkInTime: checkInTime,
    );
    checkIn.id = await db.insert(checkInTableName, checkIn.toMap());
    return checkIn;
  }

  Future<void> insertEmployee(Employee employee) async {
    final db = await open();

    final existingEmployee =
        await findEmployeeByNik(employee.nik, employee.name);
    if (existingEmployee == null) {
      await db.insert(employeeTableName, employee.toMap());
    } else {
      // data dengan nik yang sama sudah ada, lakukan update
      employee.nik = existingEmployee['nik'];
      employee.name = existingEmployee['name'];
      await update(employee);
    }
  }

  Future<List<Employee>> getAll() async {
    final db = await open();
    final maps = await db.query(employeeTableName);
    return List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
  }

  Future<List<Employee>> getAllCheckInModels() async {
    final db = await open();
    final maps = await db.query(employeeTableName);
    return List.generate(maps.length, (i) {
      final employee = Employee.fromMap(maps[i]);
      return Employee(
        nik: employee.nik,
        name: employee.name,
        position: employee.position,
      );
    });
  }

  Future<void> update(Employee employee) async {
    final db = await open();
    await db.update(employeeTableName, employee.toMap(),
        where: 'nik = ?', whereArgs: [employee.nik]);
  }

  Future<void> deleteAll() async {
    final db = await open();
    await db.delete(employeeTableName, where: '1');
  }

  Future<void> deleteById(String nik) async {
    final db = await open();
    await db.delete(employeeTableName, where: 'nik = ?', whereArgs: [nik]);
  }
}
