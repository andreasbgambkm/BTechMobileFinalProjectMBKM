import 'dart:convert';
import 'package:BTechApp_Final_Project/data/models/kemandoran_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class KemandoranRepository {
final _db = EmployeeRepository().open();
  Future<List<Kemandoran>> getAllKemandorans() async {
    final Database db = await EmployeeRepository().open();
    final List<Map<String, dynamic>> maps = await db.query(EmployeeRepository.kemandoranTableName);
    return List.generate(maps.length, (index) => Kemandoran.fromMap(maps[index]));
  }
Future<Kemandoran?> findKemandoranById(String idKemandoran) async {
  final db = await EmployeeRepository().open();
  final result = await db.rawQuery(
    'SELECT * FROM Kemandoran WHERE id_kemandoran = ?',
    [idKemandoran],
  );

  if (result.isNotEmpty) {
    return Kemandoran.fromJson(result.first);
  } else {
    return null;
  }
}


Future<void> injectFromJson() async {
  final String jsonString =
  await rootBundle.loadString('assets/data/kemandoran.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  final List<Kemandoran> kemandorans =
  jsonList.map((e) => Kemandoran.fromJson(e)).toList();

  final Database db = await EmployeeRepository().open();

  try {
    for (final kemandoran in kemandorans) {
      final existingKemandoran =
      await findKemandoranById(kemandoran.id);
      if (existingKemandoran == null) {
        await insertKemandoran(kemandoran);
      } else {
        kemandoran.id = existingKemandoran.id;
        await update(kemandoran);
      }
    }
  } finally {
    db.close(); // Tutup objek Database
  }
}

Future<void> insertKemandoran(Kemandoran kemandoran) async {
  final db = await EmployeeRepository().open();

  final existingKemandoran =
  await findKemandoranById(kemandoran.id);
  if (existingKemandoran == null) {
    await db.insert(EmployeeRepository.kemandoranTableName, kemandoran.toMap());
  } else {
    kemandoran.id = existingKemandoran.id;
    await update(kemandoran);
  }
}

Future<void> update(Kemandoran kemandoran) async {
  final db = await EmployeeRepository().open();
  await db.update(EmployeeRepository.kemandoranTableName, kemandoran.toMap(),
      where: 'id_kemandoran = ?', whereArgs: [kemandoran.id]);
}


}
