

import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:BTechApp_Final_Project/widgets/custom_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeHeader extends StatelessWidget {
  final User user;
  String greeting = '';

   HomeHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(now);

    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      greeting = 'Selamat Pagi';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Selamat Siang';
    } else if (hour >= 18 && hour < 24) {
      greeting = 'Selamat Malam';
    }

    return Container(
      child: Column(
        children:<Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$greeting, ${user.name}!",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${user.position}, ${user.division}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:<Widget> [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: AppDecoration.outlineGray300.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder10,
                    ),
                    child: IconButton(
                      icon: CustomIcon(
                        iconPath: 'assets/images/userdrawer.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                formattedDate,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: BgaColor.bgaBlack90001,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
