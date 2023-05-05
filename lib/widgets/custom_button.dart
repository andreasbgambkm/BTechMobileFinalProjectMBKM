
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:flutter/material.dart';

class BgaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  BgaButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon),
            SizedBox(width: 8),
            Text(
              text,
              style:  TextStyle(fontSize: 14, fontFamily: 'Poppins'),
            ),
          ],
        ),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              textColor ?? BgaColor.bgaWhiteA700),
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? BgaColor.bgaOrange),
          overlayColor: MaterialStateProperty.all<Color>(BgaColor.bgaOrange50),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side:  BorderSide(color: BgaColor.bgaOrange, width: 2)


            ),
          ),
        ),
      ),
    );
  }
}