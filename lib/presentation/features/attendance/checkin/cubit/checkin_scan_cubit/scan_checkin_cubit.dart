
import 'package:BTechApp_Final_Project/data/models/employee_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/checkin_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

part 'scan_checkin_state.dart';

class ScanCheckinCubit extends Cubit<ScanCheckinState> {
  ScanCheckinCubit() : super(ScanCheckinInitial());



  void onQRScanned(String barcodeType, String data, BuildContext context) async {
    emit(ScanCheckinLoading());

    List<String> qrData = data.split('|');
    if (qrData.length < 2 || qrData[0].isEmpty || qrData[1].isEmpty) {
      emit(ScanCheckinError('QR atau barcode yang discan tidak valid.'));
      return;
    }
    String nik = qrData[0];
    String name = qrData[1];

    int isCheckedIn = 1;

    final employeeData = await EmployeeRepository().findEmployeeByNik(nik, name);
    final employeeCheckin = CheckInRepository();
    final int? id = 0;

    if (employeeData == null) {
      emit(ScanCheckinError('Data tidak ditemukan.'));
      return;
    }

    final Employee employee = Employee.fromMap(employeeData);

    final existingCheckIn = await employeeCheckin.findEmployeeIsCheckedInByNik(nik, name, isCheckedIn);

    if (existingCheckIn != null) {
      emit(ScanCheckinError('Karyawan dengan NIK $nik - $name sudah melakukan check-in sebelumnya.'));
      return;
    }

    try {
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm').format(now);
      // Menghitung nilai isLated berdasarkan waktu check-in
      int isLated = (now.hour >= 8) ? 1 : 0;
      await employeeCheckin.insertCheckIn(nik, name, 1, formattedTime, isLated);
      emit(ScanCheckinSuccess(barcodeType, data, employee));


    } catch (error) {
      emit(ScanCheckinError('Gagal melakukan check-in.'));
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
