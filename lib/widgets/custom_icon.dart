import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CustomIcon extends StatelessWidget {
  final String iconPath;
  final double width;
  final double height;

  const CustomIcon({
    required this.iconPath,

    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath,
      width: width,
      height: height,
    );
  }
}

class BgaIconBackOnScanQR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },

        icon: Icon(Icons.arrow_back, color: BgaColor.bgaWhiteA700),
      ),

    );
  }
}

class BgaIconToggleFlashOnScanQR extends StatelessWidget {


  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: IconButton(
        onPressed: () async {

          await controller?.toggleFlash();
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
        ),
      ),
    );


  }
}


class BgaIconFlipCameraOnScanQR extends StatelessWidget {


  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return   Positioned(
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
    );


  }
}


class CustomIconRectangle extends StatelessWidget {
  const CustomIconRectangle({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),

          color: BgaColor.bgaOrange,
        ),
        child: InkWell(


          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              icon,
              size: 20.0,
              color: BgaColor.bgaWhiteA700,
            ),
          ),
        ),
      ),
    );
  }
}

