import 'package:BTechApp_Final_Project/core/app_expor.dart';
import 'package:BTechApp_Final_Project/data/models/attendance_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/attendance_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {


  final attendanceTableName = EmployeeRepository.attendanceTableName;
  final checkInTableName = EmployeeRepository.checkInTableName;
  final  checkOutTableName = EmployeeRepository.checkOutTableName;

  final AttendanceRepository attendanceRepository = AttendanceRepository();


  AttendanceCubit() : super(AttendanceInitial());



  Future<void> insertAttendance(Map<String, dynamic> attendanceData) async {
    try {
      final Database _database = await EmployeeRepository().open();
      await _database.insert(attendanceTableName, attendanceData);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError('Failed to insert attendance data'));
    }
  }



  Future<void> insertAttendanceData(Attendance attendance) async {
    try {
      final Database _database = await EmployeeRepository().open();

      final attendanceData = {
        'id': attendance.id,
        'nik': attendance.nik,
        'name': attendance.name,
        'idCheckIn': attendance.idCheckIn,
        'idCheckOut': attendance.idCheckOut,
        'isCheckedIn': attendance.isCheckedIn,
        'checkInTime': attendance.checkInTime,
        'isCheckedOut': attendance.isCheckedOut,
        'checkoutTime': attendance.checkoutTime,
        'note': attendance.note,
        'createdAt': attendance.createdAt,
      };

      await _database.insert(attendanceTableName, attendanceData);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError('Failed to insert attendance data'));
    }
  }



  Future<void> updateAttendances(String nik, String name, int idCheckOut, int isCheckedOut, String checkOutTime, String createdAt) async {
    try {

      await attendanceRepository.updateAttendance(nik, name, idCheckOut, isCheckedOut, checkOutTime, createdAt);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError('Failed to update attendance data'));
    }
  }


  // Future<void> updateAttendance(Attendance attendance) async {
  //   try {
  //     final Database _database = await EmployeeRepository().open();
  //
  //     final updatedAttendanceData = {
  //       'id': attendance.id,
  //       'nik': attendance.nik,
  //       'name': attendance.name,
  //       'idCheckIn': attendance.idCheckIn,
  //       'idCheckOut': attendance.idCheckOut,
  //       'isCheckedIn': attendance.isCheckedIn,
  //       'checkInTime': attendance.checkInTime,
  //       'isCheckedOut': attendance.isCheckedOut,
  //       'checkoutTime': attendance.checkoutTime,
  //       'note': attendance.note,
  //       'createdAt': attendance.createdAt,
  //     };
  //
  //     await _database.update(
  //       attendanceTableName,
  //       updatedAttendanceData,
  //       where: 'nik = ?',
  //       whereArgs: [attendance.nik],
  //     );
  //
  //     emit(AttendanceSuccess());
  //   } catch (e) {
  //     emit(AttendanceError('Failed to update attendance data'));
  //   }
  // }



}


