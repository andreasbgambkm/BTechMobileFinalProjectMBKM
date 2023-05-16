import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class BgaCustomSearchBar extends StatelessWidget {
  const BgaCustomSearchBar({Key? key, required this.onChanged}) : super(key: key);
  final Function(String) onChanged;


  @override
  Widget build(BuildContext context) {
    return  TextField(

        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: BgaColor.bgaSearchBarColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none
          ),
          hintText: 'Siapa Yang Anda Cari?',
          hintStyle: BgaTextStyle.searchBarText,
          prefixIcon: Icon(FlutterIcons.search_faw5s, size: 20.0,),
          prefixIconColor: BgaColor.bgaBlackTitleBold,
        ),



    );
  }
}
