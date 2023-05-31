import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class CustomAlertDialogSuccess {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    VoidCallback? onPressed,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: title,
      text: content,
      confirmBtnText: 'Okay',
      cancelBtnText: 'Cancel',
      confirmBtnColor: BgaColor.bgaLightGreenList,
      cancelBtnTextStyle: BgaTextStyle.subtitleBoldText,
      confirmBtnTextStyle: BgaTextStyle.subtitleBoldText,
      customAsset:'assets/images/success.png',
    );
  }
}


class CustomAlertDialogFailure {
  static void show({
    required BuildContext context,
    required QuickAlertType type,
    required String title,
    required String text,
    required String confirmBtnText,
    required Color confirmBtnColor,
    required TextStyle confirmBtnTextStyle,
    String? customAsset,
    VoidCallback? onConfirmPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (customAsset != null) Image.asset(customAsset),
              Text(text),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(confirmBtnText, style: confirmBtnTextStyle),
              onPressed: () {
                if (onConfirmPressed != null) {
                  onConfirmPressed();
                }
                Navigator.pop(context); // Menutup dialog setelah tombol ditekan
              },
            ),
          ],
        );
      },
    );
  }
}

