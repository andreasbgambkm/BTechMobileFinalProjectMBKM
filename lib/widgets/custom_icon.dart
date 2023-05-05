import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

