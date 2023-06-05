
import 'package:BTechApp_Final_Project/data/models/checkin_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class CheckInRepository {

    static const String tableName = 'CheckIn';

    Future<Database> createCheckInTable() async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, 'Employee_database.db');

    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
            '''
          CREATE TABLE IF NOT EXISTS $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nik TEXT,
            name TEXT,
            isCheckedIn INTEGER,
            checkInTime TEXT,
            FOREIGN KEY (nik) REFERENCES Employees(nik)
          )
          '''
        );
      },
      version: 2,
    );
  }

  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      if (oldVersion < 9) {
        await db.transaction((txn) async {
          await txn.execute('BEGIN TRANSACTION;');
          await txn.execute('CREATE TABLE CheckIn_temp AS SELECT * FROM CheckIn;');
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
        await createCheckInTable();
      },
      version: 8,
    );
    return db;
  }

  // Get semua CheckIn dengan isCheckedIn bernilai 1
  Future<List<CheckInModel>> getAllSuccessfulCheckIns() async {
    final db = await _getDb();
    final maps = await db.query(tableName, where: 'isCheckedIn = ?', whereArgs: [1]);
    print(maps);
    return List.generate(maps.length, (i) {
      final checkIn = CheckInModel.fromMap(maps[i]);
      return checkIn;
    });
  }


//open

  Future<Database> openCheckIn() async {
    final dbPath = await getDatabasesPath();
    final databasePath = join(dbPath, 'Employee_database.db');

    return openDatabase(
      databasePath,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE IF NOT EXISTS $tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nik TEXT,
            name TEXT,
            isCheckedIn INTEGER,
            checkInTime TEXT,
            FOREIGN KEY (nik) REFERENCES Employees(nik)
          )
          ''',
        );
      },
      version: 50,
    );
  }

  Future<Map<String, dynamic>?> findEmployeeIsCheckedInByNik(String nik, String name, int isCheckedIn) async {
    final Database db = await _getDb() ;
    final List<Map<String, dynamic>> maps = await db.query(
      CheckInRepository.tableName,
      where: "nik = ? AND name = ? AND isCheckedIn = ?",
      whereArgs: [nik, name, isCheckedIn],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
  // Insert CheckIn baru
  Future<CheckInModel> insertCheckIn(String nik, String name, int isCheckedIn, String checkInTime, int isLated) async {
    final db = await openCheckIn();
    final checkIn = CheckInModel(
      nik: nik,
      name: name,
      isCheckedIn: isCheckedIn,
      checkInTime: checkInTime,
      isLated : isLated,
    );
    checkIn.id = await db.insert(tableName, checkIn.toMap());
    return checkIn;
  }


  // Update CheckIn
  Future<void> updateCheckIn(CheckInModel checkIn) async {
    final db = await _getDb();
    await db.update(
      tableName,
      checkIn.toMap(),
      where: 'id = ?',
      whereArgs: [checkIn.id],
    );
  }

  Future<void> deleteAllCheckIn() async {
    final db = await _getDb();
    await db.delete(tableName, where: '1');
  }

}

