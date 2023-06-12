import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class AttendanceRepository {

  static const String tableName = 'Attendance';

  Future<Database> createAttendanceTable() async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, 'Employee_database.db');

    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
            '''
         CREATE TABLE IF NOT EXISTS attendance (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employeeId INTEGER,
            checkInId INTEGER,
            checkOutId INTEGER,
            createdAt TEXT,
            FOREIGN KEY (employeeId) REFERENCES Employees(id),
            FOREIGN KEY (checkInId) REFERENCES CheckIn(id),
            FOREIGN KEY (checkOutId) REFERENCES CheckOut(id)
)

          '''
        );
      },
      version: 1,
    );
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (oldVersion < 9) {
        await db.transaction((txn) async {
          await txn.execute('BEGIN TRANSACTION;');
          await txn.execute('CREATE TABLE Attendance_temp AS SELECT * FROM Attendance;');
          await txn.execute('COMMIT;');
        });
      }
    }
  }

  Future<Database> _getDb() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(
      '$dbPath/Employee_database.db',
      onCreate: (db, version) async {
        await createAttendanceTable();
      },
      version: 1,
    );
    return db;
  }



//open

  Future<Database> openAttendance() async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, 'Employee_database.db');

    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
          '''
         CREATE TABLE IF NOT EXISTS attendance (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employeeId INTEGER,
            checkInId INTEGER,
            checkOutId INTEGER,
            createdAt TEXT,
            FOREIGN KEY (employeeId) REFERENCES Employees(nik),
            FOREIGN KEY (checkInId) REFERENCES CheckIn(id),
            FOREIGN KEY (checkOutId) REFERENCES CheckOut(id)
)
          ''',
        );
      },
      version: 1,
    );
  }


  Future<void> deleteAllAttendance() async {
    final db = await _getDb();
    await db.delete(tableName, where: '1');
  }

  Future<void> updateAttendance(String nik, String name, int idCheckOut, int isCheckedOut, String checkOutTime, String createdAt) async {
    final db = await _getDb();
    await db.update(
      tableName,
      {'nik': nik,
      'name': name,
      'idCheckOut': idCheckOut,
        'isCheckedOut':isCheckedOut,
      'checkOutTime': checkOutTime,
      'createdAt' : createdAt},
      where: 'nik = ? AND name = ?',
      whereArgs: [nik, name],
    );
  }

}

