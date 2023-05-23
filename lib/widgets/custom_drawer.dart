
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:BTechApp_Final_Project/presentation/login/cubit/cubit.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BgaDrawer extends StatelessWidget {

  final User user;

  const BgaDrawer({super.key,  required this.user});




  @override
  Widget build(BuildContext context) {
    final LoginCubit loginCubit = LoginCubit();

    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * (3/4); // Menghitung lebar drawer sebesar 1/3 dari lebar layar

    return Drawer(
      backgroundColor: BgaColor.bgaWhiteA700,
      width: drawerWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              color: BgaColor.bgaWhiteA700,
              child: Row(
                children: [
                  CircleAvatar( backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/userdrawer.png'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //fetchdata
                            '${user.name}',
                            style: TextStyle(
                              color: BgaColor.bgaBlack900,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            //fetchdata
                            '${user.position} ${user.division}',
                            style: TextStyle(
                              color: BgaColor.bgaBlack900,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.print, color: BgaColor.bgaOrange,),
              title: const Text('Setting Printer',
                style: TextStyle(
                    fontFamily: 'Poppins',
                fontSize: 13),),
              onTap: () {
                // Navigate to home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: BgaColor.bgaOrange,),
              title: Text('Pengaturan Aplikasi',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13),),
              onTap: () {
                // Navigate to settings screen
              },
            ),

            ListTile(
              leading: Icon(Icons.exit_to_app, color: BgaColor.bgaOrange,),
              title: Text('Logout',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13),
              ),
              onTap: () {

                loginCubit.performLogout(context);


              },
            ),

          ],
        ),
      ),
    );
  }
}
