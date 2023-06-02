import 'dart:developer';
import 'dart:io';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/cubit/checkin_scan_cubit/scan_checkin_cubit.dart';
import 'package:BTechApp_Final_Project/repository/checkin_repository.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:BTechApp_Final_Project/widgets/custom_alert.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class QRScanner extends StatefulWidget {
  static String routeName = "/checkin";
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
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
    controller.scannedDataStream.listen((scanData) {
      Vibration.vibrate(duration: 300);
      _showBottomSheet(context, describeEnum(scanData.format), scanData.code.toString());
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

  void _showBottomSheet(context, String barcodeType, String data) async {
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
            onPressed: (){
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

    int isCheckedIn = 1;

    final employee = await EmployeeRepository().findEmployeeByNik(nik, name);
    final employee_checkin = CheckInRepository();
    final int? id = 0;

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

    final existingCheckIn = await employee_checkin.findEmployeeIsCheckedInByNik(nik, name, isCheckedIn);

    if (existingCheckIn != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BgaCustomAlert(
            title: 'Karyawan Sudah Check In',
            descriptions: 'Karyawan dengan NIK $nik - $name sudah melakukan check-in sebelumnya.',
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
      builder: (BuildContext context) {
        return BlocProvider<ScanCheckinCubit>(
          create: (context) => ScanCheckinCubit(),
          child: BlocBuilder<ScanCheckinCubit, ScanCheckinState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.bgaAvatarRadius45
                ),
                child: DraggableScrollableSheet(
                  initialChildSize: 0.8,
                  minChildSize: 0.2,
                  maxChildSize: 0.8,
                  expand: false,
                  builder: (context, scrollController) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text('Barcode Type: $barcodeType'),
                            ),
                            ListTile(
                              leading: Icon(Icons.code),
                              title: Text('${employee['nik']} - ${employee['name']}'),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: DropdownButton<String>(
                                  value: 'Option 1',
                                  items: [
                                    DropdownMenuItem(
                                      value: 'Option 1',
                                      child: Text('Wajah Tidak Terdaftar'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Option 2',
                                      child: Text('Wajah Tidak Terdeteksi'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Option 3',
                                      child: Text('Wajah Terlalu Tampan'),
                                    ),
                                  ],
                                  onChanged: (value) {},
                                  hint: Text('Select an option'),
                                  isExpanded: true,
                                ),
                              ),
                            ),
                            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
                            BgaButton(
                              text: 'Lanjutkan',
                              onPressed: () async {
                                final now = DateTime.now();
                                final formattedTime = DateFormat('HH:mm').format(now);
                                context.read<CheckInCubit>().getAllSuccessfulCheckedIn();
                                await employee_checkin.insertCheckIn(nik, name, 1, formattedTime);
                                context.read<CheckInCubit>().refresh();
                                Navigator.pop(context);
                                _startCamera();
                              },
                            ),
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


