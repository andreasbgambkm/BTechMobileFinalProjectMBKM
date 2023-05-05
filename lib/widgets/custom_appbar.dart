
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: Text(title),
      centerTitle: true,
      backgroundColor: BgaColor.bgaOrange,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: BgaColor.bgaWhiteA700,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
