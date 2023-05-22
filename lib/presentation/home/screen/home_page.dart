import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:BTechApp_Final_Project/repository/EmployeeRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';

import 'package:BTechApp_Final_Project/widgets/custom_icon.dart';
import 'package:BTechApp_Final_Project/widgets/custom_drawer.dart';
import 'package:BTechApp_Final_Project/widgets/custom_bottom_navigation.dart';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_rkh.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_gps.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_menu.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_tasks.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  final User user;
  int? currentIndex;
  String greeting = '';

   HomePage({Key? key, required this.user}) : super(key: key);

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

    return Scaffold(
      backgroundColor: BgaColor.bgaBodyColor,
      drawer: BgaDrawer(user: user,),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: BgaPaddingSize.getPaddingBody(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: BgaHomeConfig.getPaddingTopQuery(context),
                    ),
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
                              style: BgaTextStyle.titleBoldText,
                            ),
                            SizedBox(
                              height: BgaSizedboxSize.getSizedBoxLowHeight(),
                            ),
                            Text(
                              '${user.position}, ${user.division}',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: BgaTextStyle.subtitleText2,
                            ),
                            SizedBox(
                              height: BgaSizedboxSize.getSizedBoxMaxHeight(),
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
                                  iconPath: userDrawerIcon,
                                  width: BgaIconSize.getIconUserWidth(),
                                  height: BgaIconSize.getIconUserHeight(),
                                ),
                                onPressed: () async {
                                  await EmployeeRepository().open();
                                  await EmployeeRepository().injectFromJson();
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          formattedDate,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: BgaTextStyle.subtitleText,
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    const HomeGps(),
                    const HomeRkh(),
                    HomeMenu(),
                    const HomeTasks(),
                  ],
                ),
              ),
            ),
          );
        }
      ),

      bottomNavigationBar: BgaBubbleBottomNavigation(currentIndex: 0, onTap: (index){

      },)
    );
  }
}


