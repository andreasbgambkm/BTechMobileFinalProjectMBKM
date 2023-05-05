import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'cubit.dart';
import 'package:BTechApp_Final_Project/widgets/custom_icon.dart';
import 'package:BTechApp_Final_Project/widgets/custom_drawer.dart';
import 'package:BTechApp_Final_Project/widgets/custom_bottom_navigation.dart';
import 'package:BTechApp_Final_Project/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_rkh.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_gps.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_menu.dart';
import 'package:BTechApp_Final_Project/presentation/home/components/home_tasks.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  final User user;
  late int currentIndex;
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
                      height: MediaQuery.of(context).padding.top/2.5,
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
                                onPressed: () {Scaffold.of(context).openDrawer();
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
                    HomeGps(),
                    HomeRkh(),
                    HomeMenu(),
                    HomeTasks(),
                  ],
                ),
              ),
            ),
          );
        }
      ),

      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        // currentIndex: currentIndex,
        //onTap: changePage,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        tilesPadding: EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: BgaColor.bgaOrange,
            icon: Icon(
              Icons.home_filled,
              color: BgaColor.bgaOrange,
            ),
            activeIcon: Icon(
              Icons.home_filled,
              color: BgaColor.bgaOrange,
            ),
            title: Text("Beranda"),
          ),
          BubbleBottomBarItem(
              backgroundColor: BgaColor.bgaOrange,
              icon: Icon(
                Icons.dashboard,
                color: BgaColor.bgaOrange,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: BgaColor.bgaOrange,
              ),
              title: Text("Logs")),



        ],
      ),
    );
  }
}


