import 'dart:developer';
import 'dart:io';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/repository/checkin_repository.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
                cutOutSize: MediaQuery.of(context).size.width/1.5),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),

      Positioned(
        top: 20,
        left: 20,
        child: IconButton(
          onPressed: () {
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

    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('no Permission', style: BgaTextStyle.titleBoldText,)),
      );
    }
  }


  void _showBottomSheet(context, String barcodeType, String data) async {
    List<String> qrData = data.split('|');
    String nik = qrData[0];
    String name = qrData[1];

    int isCheckedIn = 1;

    final employee = await EmployeeRepository().findEmployeeByNik(nik, name);
    final employee_checkin = CheckInRepository();
    final int? id= 0;
    if (employee == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data tidak ditemukan.', style: BgaTextStyle.titleBoldText,)),
      );
      return;
    }

    final existingCheckIn = await employee_checkin.findEmployeeIsCheckedInByNik(nik, name, isCheckedIn);

    if (existingCheckIn != null) {
      // validasi ketika pekerja sudah melakukan check-in sebelumnya
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Karyawan Sudah Check-In'),
            content: Text('Karyawan dengan NIK $nik - $name sudah melakukan check-in sebelumnya.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50.0),
            ),
          ),
          child: Padding(
            padding: BgaPaddingSize.getPaddingBottomSheetAll(),
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
                DropdownButton<String>(
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
                  onChanged: (value) {
                    // Handle dropdown item change
                  },
                  hint: Text('Select an option'),
                  isExpanded: true,
                ),
                SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),


        BgaButton(
        text: 'Lanjutkan',
          onPressed: () async {

            final now = DateTime.now();
            final formattedTime = DateFormat('HH:mm').format(now);
            // await employee_checkin.openCheckIn();
            await employee_checkin.insertCheckIn( nik, name, 1, formattedTime);
            Navigator.pop(context);


          },
        ),

        ],
            ),
          ),
        );
      },
    );
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}


