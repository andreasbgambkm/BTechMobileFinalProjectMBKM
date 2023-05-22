import 'package:BTechApp_Final_Project/models/checkout_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class CheckOutRepository {

  static const String tableName = 'CheckOut';

  Future<Database> createCheckOutTable() async {
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
            isCheckedOut INTEGER,
            CheckOutTime TEXT,
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
          await txn.execute('CREATE TABLE CheckOut_temp AS SELECT * FROM CheckOut;');
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
        await createCheckOutTable();
      },
      version: 8,
    );
    return db;
  }

  // Get semua CheckOut dengan isCheckedOut bernilai 1
  Future<List<CheckOutModel>> getAllSuccessfulCheckOut() async {
    final db = await _getDb();
    final maps = await db.query(tableName, where: 'isCheckedOut = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) {
      final CheckOut = CheckOutModel.fromMap(maps[i]);
      return CheckOut;
    });
  }


//open

  Future<Database> openCheckOut() async {
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
            isCheckedOut INTEGER,
            CheckOutTime TEXT,
            note TEXT,
            FOREIGN KEY (nik) REFERENCES Employees(nik)
          )
          ''',
        );
      },
      version: 50,
    );
  }

  Future<Map<String, dynamic>?> findEmployeeIsCheckedOutByNik(String nik, String name, int isCheckedOut) async {
    final Database db = await _getDb() ;
    final List<Map<String, dynamic>> maps = await db.query(
      CheckOutRepository.tableName,
      where: "nik = ? AND name = ? AND isCheckedOut = ?",
      whereArgs: [nik, name, isCheckedOut],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
  // Insert CheckOut baru
  Future<CheckOutModel> insertCheckOut(String nik, String name, int isCheckedOut, String checkoutTime, String note) async {
    final db = await openCheckOut();
    final CheckOut = CheckOutModel(
      nik: nik,
      name: name,
      isCheckedOut: isCheckedOut,
      checkoutTime: checkoutTime,
      note: note,
    );
    CheckOut.id = await db.insert(tableName, CheckOut.toMap());
    return CheckOut;
  }


  // Update CheckOut
  Future<void> updateCheckOut(CheckOutModel CheckOut) async {
    final db = await _getDb();
    await db.update(
      tableName,
      CheckOut.toMap(),
      where: 'id = ?',
      whereArgs: [CheckOut.id],
    );
  }

}

