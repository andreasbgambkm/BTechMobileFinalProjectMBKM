import 'dart:convert';

import 'package:BTechApp_Final_Project/data/models/division_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DivisionRepository {


  final _db = EmployeeRepository().open();
  Future<void> insertDivision(Division division) async {
    final Database db = await EmployeeRepository().open();
    await  db.insert(EmployeeRepository.divisionTableName, division.toMap());
  }

  Future<List<Division>> getAllDivisions() async {
    final Database db = await EmployeeRepository().open();
    final List<Map<String, dynamic>> maps = await db.query(EmployeeRepository.divisionTableName);
    return List.generate(maps.length, (index) => Division.fromMap(maps[index]));
  }

  Future<void> update(Division division) async {
    final db = await EmployeeRepository().open();
    await db.update(EmployeeRepository.divisionTableName, division.toMap(),
        where: 'id_division = ?', whereArgs: [division.id]);
  }

  Future<void> injectFromJson() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/division.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<Division> divisions = jsonList.map((e) => Division.fromJson(e)).toList();

    final Database db = await EmployeeRepository().open();

    try {
      for (final division in divisions) {
        final existingDivision = await findDivisionById(division.id);
        if (existingDivision == null) {
          await insertDivision(division);
        } else {
          division.id= existingDivision['id_division'];
          await update(division);
        }
      }
    } finally {
      db.close(); // Tutup objek Database
    }
  }

  Future<Map<String, dynamic>?> findDivisionById(
      String id) async {
    final Database db = await EmployeeRepository().open();
    final List<Map<String, dynamic>> maps = await db.query(
      EmployeeRepository.divisionTableName,
      where: "id_division = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

}
