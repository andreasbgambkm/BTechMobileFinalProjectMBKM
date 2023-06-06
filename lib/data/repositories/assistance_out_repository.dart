
import 'package:BTechApp_Final_Project/data/models/assistance_out_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';

import 'package:sqflite/sqflite.dart';

class AssistanceOutRepository {
  final EmployeeRepository openDb = EmployeeRepository();

  Future<Map<String, dynamic>?> findAssistanceOut( id_assistance, nik, estate, division, kemandoran) async {
    final Database db = await openDb.open();
    final List<Map<String, dynamic>> maps = await db.query(
      EmployeeRepository.assistanceOutTableName,
      where: " id_assistance = ? AND nik =? AND estate = ? AND division = ? AND kemandoran = ?",
      whereArgs: [id_assistance, nik, estate, division, kemandoran],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }


  Future<void> insertAssistanceOut(AssistanceOut AssistanceOut) async {
    final db = await openDb.open();

    final existingAssistanceOut = await findAssistanceOut(AssistanceOut.id, AssistanceOut.employeeNik, AssistanceOut.estate, AssistanceOut.division, AssistanceOut.kemandoran);
    if (existingAssistanceOut == null) {
      await db.insert(EmployeeRepository.assistanceOutTableName, AssistanceOut.toMap());
    } else {
      // data dengan id yang sama sudah ada, lakukan update
      AssistanceOut = existingAssistanceOut['id'];
      await update(AssistanceOut);
    }
  }

 
  Future<void> update(AssistanceOut AssistanceOut) async {
    final db = await openDb.open();
    await db.update(EmployeeRepository.assistanceOutTableName, AssistanceOut.toMap(),
        where: 'nik = ?', whereArgs: [AssistanceOut.employeeNik]);
  }

  Future<void> deleteAll() async {
    final db = openDb.open();
    //await db.delete(EmployeeRepository.assistanceOutTableName, where: '1');
  }


}
