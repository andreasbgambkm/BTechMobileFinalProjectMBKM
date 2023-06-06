import 'dart:convert';

import 'package:BTechApp_Final_Project/data/models/estate_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class EstateRepository {
  final _db = EmployeeRepository().open();


  Future<void> insertEstate(Estate estate) async {
    final Database db = await EmployeeRepository().open();
    await db.insert(EmployeeRepository.estateTableName, estate.toMap());
  }

  Future<List<Estate>> getAllEstates() async {
    final Database db = await EmployeeRepository().open();
    final List<Map<String, dynamic>> maps = await db.query(EmployeeRepository.estateTableName);
    return List.generate(maps.length, (index) => Estate.fromMap(maps[index]));
  }

  Future<Map<String, dynamic>?> findEstateById(
      String id) async {
    final Database db = await EmployeeRepository().open();
    final List<Map<String, dynamic>> maps = await db.query(
      EmployeeRepository.estateTableName,
      where: "id_estate = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
  Future<void> injectFromJson() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/estate.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<Estate> estates =
    jsonList.map((e) => Estate.fromJson(e)).toList();

    final Database db = await EmployeeRepository().open();

    try {
      for (final estate in estates) {
        final existingEstate = await findEstateById(estate.id);
        if (existingEstate == null) {
          await insertEstate(estate);
        } else {
          estate.id= existingEstate['id_estate'];
          await update(estate);
        }
      }
    } finally {
      db.close(); // Tutup objek Database
    }
  }
  Future<void> update(Estate estate) async {
    final db = await EmployeeRepository().open();
    await db.update(EmployeeRepository.estateTableName, estate.toMap(),
        where: 'id_estate = ?', whereArgs: [estate.id]);
  }
}
