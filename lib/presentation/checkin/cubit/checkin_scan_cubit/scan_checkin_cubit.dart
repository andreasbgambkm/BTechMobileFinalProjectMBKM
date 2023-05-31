import 'package:BTechApp_Final_Project/models/employee_model.dart';
import 'package:BTechApp_Final_Project/repository/checkin_repository.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
part 'scan_checkin_state.dart';

class QRScannerCubit extends Cubit<QRScannerState> {
  QRScannerCubit() : super(QRScannerInitial());

  var logger = Logger();

  void onQRScanned(String barcodeType, String data, BuildContext context) async {
    emit(QRScannerLoading());

    List<String> qrData = data.split('|');
    String nik = qrData[0];
    String name = qrData[1];

    int isCheckedIn = 1;

    final Map<String, dynamic>? employeeData = await EmployeeRepository().findEmployeeByNik(nik, name);
    final employeeCheckIn = CheckInRepository();
    final int? id = 0;

    if (employeeData == null) {
      emit(QRScannerError('Data tidak ditemukan.'));
      return;
    }

    final Employee employee = Employee.fromMap(employeeData);

    final existingCheckIn = await employeeCheckIn.findEmployeeIsCheckedInByNik(nik, name, isCheckedIn);

    if (existingCheckIn != null) {
      emit(QRScannerError('Karyawan dengan NIK $nik - $name sudah melakukan check-in sebelumnya.'));
      return;
    }

    try {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(now);
      await employeeCheckIn.insertCheckIn(nik, name, 1, formattedTime);
      emit(QRScannerSuccess(employee, barcodeType));
    } catch (error) {
      emit(QRScannerError('Gagal melakukan check-in.'));
      logger.e(error.toString());
    }
  }

  void selectOption(String option) {
    emit(QRScannerSelectOption(option));
  }
}

