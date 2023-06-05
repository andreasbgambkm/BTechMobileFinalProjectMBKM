
import 'package:BTechApp_Final_Project/data/models/employee_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/checkout_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

part 'scan_checkout_state.dart';

class ScanCheckoutCubit extends Cubit<ScanCheckoutState> {
  ScanCheckoutCubit() : super(ScanCheckoutInitial());



  void onQRScanned(String barcodeType, String data, BuildContext context) async {
    emit(ScanCheckoutLoading());

    List<String> qrData = data.split('|');
    if (qrData.length < 2 || qrData[0].isEmpty || qrData[1].isEmpty) {
      emit(ScanCheckoutError('QR atau barcode yang discan tidak valid.'));
      return;
    }
    String nik = qrData[0];
    String name = qrData[1];
    String? note;

    int isCheckedIn = 1;

    final employeeData = await EmployeeRepository().findEmployeeByNik(nik, name);
    final employeecheckout = CheckOutRepository();
    final int? id = 0;

    if (employeeData == null) {
      emit(ScanCheckoutError('Data tidak ditemukan.'));
      return;
    }

    final Employee employee = Employee.fromMap(employeeData);

    final existingcheckout = await employeecheckout.findEmployeeIsCheckedOutByNik(nik, name);

    if (existingcheckout != null) {
      emit(ScanCheckoutError('Karyawan dengan NIK $nik - $name sudah melakukan check-in sebelumnya.'));
      return;
    }

    try {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(now);
      await employeecheckout.insertCheckOut(nik, name, 1, formattedTime,note!);
      emit(ScanCheckoutSuccess(barcodeType, data, employee));


    } catch (error) {
      emit(ScanCheckoutError('Gagal melakukan check-in.'));
    }
  }


  void restartScanCamera() {
    final currentState = state;
    if (currentState is CameraState) {
      final newCameraState = CameraState(!currentState.isCameraOpen);
      emit(newCameraState);
    }
  }

}
