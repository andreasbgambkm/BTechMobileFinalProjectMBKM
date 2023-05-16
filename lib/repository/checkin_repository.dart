import 'package:BTechApp_Final_Project/models/checkin_model.dart';
import 'package:sqflite/sqflite.dart';

class CheckInRepository {
  static const String tableName = 'CheckIn';

  Future<Database> _getDb() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(
      '$dbPath/Employee_database.db',
      onCreate: (db, version) async {
        await createCheckInTable(db);
      },
      version: 1,
    );
    return db;
  }

  // membuat tabel CheckIn
  Future<void> createCheckInTable(Database db) async {
    await db.execute('''
        CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nik TEXT,
          name TEXT,
          isCheckedIn INTEGER,
          checkinTime TEXT,
          FOREIGN KEY (nik) REFERENCES Employees(nik)
        )
      ''');
  }

  // get semua CheckIn
  Future<List<CheckInModel>> getAllCheckInModels() async {
    final db = await _getDb();
    final maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      final checkin = CheckInModel.fromMap(maps[i]);
      return checkin;
    });
  }

  // insert CheckIn baru
  Future<void> insertCheckIn(String nik, String name, int isCheckedIn, String checkinTime) async {
    final db = await _getDb();
    await db.insert(tableName, {
      'nik': nik,
      'name': name,
      'isCheckedIn': isCheckedIn,
      'checkinTime': checkinTime,
    });
  }

  // update CheckIn
  Future<void> updateCheckIn(CheckInModel checkin) async {
    final db = await _getDb();
    await db.update(
      tableName,
      checkin.toMap(),
      where: 'id = ?',
      whereArgs: [checkin.id],
    );
  }

  // delete CheckIn
  Future<void> deleteCheckIn(int id) async {
    final db = await _getDb();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

