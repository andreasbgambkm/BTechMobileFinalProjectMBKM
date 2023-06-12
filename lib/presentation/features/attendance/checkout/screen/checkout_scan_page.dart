import 'dart:developer';
import 'dart:io';

import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/models/attendance_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/checkin_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/checkout_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/employee_repository.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/attendance/attendance_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/checkout/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/checkout/cubit/checkout_scan_cubit/scan_checkout_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_alert.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class QRScannerCheckOut extends StatefulWidget {
  static String routeName = "/checkout";

  const QRScannerCheckOut({Key? key}) : super(key: key);

  @override
  State<QRScannerCheckOut> createState() => _QRScannerCheckOutState();
}

class _QRScannerCheckOutState extends State<QRScannerCheckOut> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isCameraPaused = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
      isCameraPaused = true;
    }
    controller!.resumeCamera();
    isCameraPaused = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: BgaColor.bgaOrange,
              borderRadius: BorderRadiusStyle.borderRadiusQR10,
              borderLength: BorderRadiusStyle.borderLengthQR,
              borderWidth: BorderRadiusStyle.borderWidthQR,
              cutOutSize: MediaQuery.of(context).size.width / 1.5,
            ),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              onPressed: () {
                _startCamera();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: BgaColor.bgaWhiteA700),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                return IconButton(
                  onPressed: () async {
                    await controller?.toggleFlash();
                  },
                  icon: Icon(
                    snapshot.data == true ? Icons.flash_on_outlined : Icons.flash_off_outlined,
                    color: BgaColor.bgaWhiteA700,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              onPressed: () async {
                await controller?.flipCamera();
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.flip_camera_android_rounded, color: BgaColor.bgaWhiteA700);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      Vibration.vibrate(duration: 300);
      await _showBottomSheet(context, describeEnum(scanData.format), scanData.code.toString());
      controller.pauseCamera();
      isCameraPaused = true;
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'no Permission',
            style: BgaTextStyle.titleBoldText,
          ),
        ),
      );
    }
  }

  Future <void> _showBottomSheet(BuildContext context, String barcodeType, String data) async {
    List<String> qrData = data.split('|');
    if (qrData.length < 2 || qrData[0].isEmpty || qrData[1].isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BgaCustomAlert(
            title: 'QR Tidak Valid',
            text: 'Tutup',
            descriptions: 'QR atau barcode yang discan tidak valid.',
            img: Image.asset(imageAlertError),
            onPressed: () {
              _startCamera();
              Navigator.pop(context);
            },
          );
        },
      );
      return;
    }

    String nik = qrData[0];
    String name = qrData[1];
    int isCheckedOut = 1;
    int isCheckedIn = 1;

    final employee = await EmployeeRepository().findEmployeeByNik(nik, name);
    final employeeCheckout = CheckOutRepository();
    final employeeCheckin = CheckInRepository();

    if (employee == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BgaCustomAlert(
            title: 'Terjadi Kesalahan',
            text: 'OK',
            descriptions: 'Data Tidak Ditemukan',
            img: Image.asset(imageAlertDefault),
            onPressed: () {
              _startCamera();
              Navigator.pop(context);
            },
          );
        },
      );
      return;
    }

    final existingCheckout = await employeeCheckout.findEmployeeIsCheckedOutByNik(nik, name);
    final isCheckIn = await employeeCheckin.findEmployeeIsCheckedInByNik(nik, name, isCheckedIn);

    if (isCheckIn == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BgaCustomAlert(
            title: 'Belum Check In',
            text: 'OK',
            descriptions: 'Pekerja dengan NIK $nik - $name belum melakukan check-in.',
            img: Image.asset(imageAlertError),
            onPressed: () {
              _startCamera();
              Navigator.pop(context);
            },
          );
        },
      );


      return;
    }

    if (existingCheckout != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BgaCustomAlert(
            title: 'Karyawan Sudah Check Out',
            descriptions: 'Karyawan dengan NIK $nik - $name sudah melakukan check-out sebelumnya.',
            text: 'OK',
            img: Image.asset(imageAlertError),
            onPressed: () {
              _startCamera();
              Navigator.pop(context);
            },
          );
        },
      );
      return;
    }


    showModalBottomSheet(
      context: context,

      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.customTopBorder25),
      builder: (BuildContext context) {
        return BlocProvider<ScanCheckoutCubit>(
          create: (context) => ScanCheckoutCubit(),
          child: BlocBuilder<ScanCheckoutCubit, ScanCheckoutState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.bgaAvatarRadius45,
                ),
                child: DraggableScrollableSheet(
                  initialChildSize: 0.8,
                  minChildSize: 0.2,
                  maxChildSize: 0.8,
                  expand: false,
                  builder: (context, scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadiusStyle.customTopBorder50,
                      child: Container(
                        color: Colors.white,
                        padding: BgaPaddingSize.getPaddingBody(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: BgaPaddingSize.getPaddingBottom8(),
                                child: ListTile(
                                  title: Text('NIK - Nama', style: BgaTextStyle.subtitleText,),
                                  subtitle:  Text('${employee['nik']} - ${employee['name']}', style: BgaTextStyle.titleBoldText,),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: BgaPaddingSize.getPaddingBottom8(),
                                child: ListTile(
                                  title: Text('Divisi', style: BgaTextStyle.subtitleText,),
                                  subtitle:  Text('${employee['division']}', style: BgaTextStyle.titleBoldText,),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: BgaPaddingSize.getPaddingBottom8(),
                                child: ListTile(
                                  title: Text('Jabatan', style: BgaTextStyle.subtitleText,),
                                  subtitle:  Text('${employee['position']}', style: BgaTextStyle.titleBoldText,),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: BgaPaddingSize.getPaddingBottom8(),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      value: 'Option 1',
                                      hint: Text('Select an option'),
                                      iconStyleData: IconStyleData(
                                        icon: Padding(
                                          padding: BgaPaddingSize.getPaddingLeftRight20(),
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.orange,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Option 1',
                                          child: Text('Alasan Menggunakan Nik', style: BgaTextStyle.subtitleText,),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Option 2',
                                          child: Text('Wajah Tidak Terdeteksi', style: BgaTextStyle.titleBoldText),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Option 3',
                                          child: Text('Wajah Belum Terdaftar', style: BgaTextStyle.titleBoldText),
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),

                            BgaButton(
                              text: 'Lanjutkan',
                              onPressed: () async {
                                final now = DateTime.now();
                                final formattedTime = DateFormat('HH:mm').format(now);
                                final createdAt = DateFormat('yyyy-MM-dd').format(now);

                                final database = await EmployeeRepository().open();
                                // final attendanceCubit = BlocProvider.of<AttendanceCubit>(context, listen: false);

                                context.read<CheckOutCubit>().getAllSuccessfulCheckedOut();
                                await context.read<CheckOutCubit>().insertCheckOut(nik, name, isCheckedOut, formattedTime, '', createdAt);
                                context.read<CheckOutCubit>().refresh();

                                final checkOutIdResult = await database.rawQuery('SELECT last_insert_rowid()');
                                final checkOutId = checkOutIdResult.first.values.first as int;

                                await context.read<AttendanceCubit>().updateAttendances(nik, name, checkOutId, isCheckedOut, formattedTime, createdAt);


                                Navigator.pop(context);
                                _startCamera();
                              },
                            ),

                            // BgaButton(
                            //     text: 'Lanjutkan',
                            //     onPressed: () async {
                            //       final now = DateTime.now();
                            //       final formattedTime = DateFormat('HH:mm').format(now);
                            //       context.read<CheckOutCubit>().getAllSuccessfulCheckedOut();
                            //      await  context.read<CheckOutCubit>().insertCheckOut(nik, name, isCheckedIn, formattedTime,'');
                            //      context.read<CheckOutCubit>().refresh();
                            //       Navigator.pop(context);
                            //       _startCamera();}
                            //
                            // ),


                            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _startCamera() {
    if (controller != null && isCameraPaused) {
      controller!.resumeCamera();
      isCameraPaused = false;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
