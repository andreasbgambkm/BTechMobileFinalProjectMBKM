import 'package:BTechApp_Final_Project/core/app_expor.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/data/models/login_model.dart';
import 'package:BTechApp_Final_Project/presentation/features/dashboard/home/components/home_gps.dart';
import 'package:BTechApp_Final_Project/presentation/features/dashboard/home/components/home_menu.dart';
import 'package:BTechApp_Final_Project/presentation/features/dashboard/home/components/home_rkh.dart';
import 'package:BTechApp_Final_Project/presentation/features/dashboard/home/components/home_tasks.dart';
import 'package:BTechApp_Final_Project/presentation/features/dashboard/home/cubit/cubit.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_bottom_navigation.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_drawer.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  final User user;
  int? currentIndex;
  String greeting = '';

   HomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    context.read<HomeCubit>().updateGreeting(now);
    
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(now);
    context.read<HomeCubit>().updateFormattedDate(formattedDate);


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
                            BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                                return Text('${state.greeting}, ${user.name}!',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: BgaTextStyle.titleBoldText,
                            );
                            },
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
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                          return Text(
                          state.formattedDate,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: BgaTextStyle.subtitleText,
                        );
                  },
                ),
                      ],
                    ),
                    SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight(),),
                    const HomeGps(),
                    const HomeRkh(),
                    const HomeMenu(),
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


