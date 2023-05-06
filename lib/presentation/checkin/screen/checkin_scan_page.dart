import 'dart:developer';
import 'dart:io';

import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  static String routeName = "/checkin_scanner";
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
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width/1.5),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return Icon(Icons.flash_on_outlined, color: BgaColor.bgaWhiteA700,);
                    } else {
                      return Icon(Icons.flash_off_outlined,  color: BgaColor.bgaWhiteA700);
                    }
                  },
                )),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.flip_camera_android_rounded, color: BgaColor.bgaWhiteA700);
                  } else {
                    return const Text('loading');
                  }
                },
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: result != null
          ? FloatingActionButton.extended(
        onPressed: () {
          _showBottomSheet(
              context, describeEnum(result!.format), result!.code.toString());
        },
        label: Text(
          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
          textAlign: TextAlign.center,
        ),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _showBottomSheet(BuildContext context, String barcodeType, String data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Barcode Type: $barcodeType'),
              ),
              ListTile(
                leading: Icon(Icons.code),
                title: Text('Data: $data'),
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text('Close'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
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


