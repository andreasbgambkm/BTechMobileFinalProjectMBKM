import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:BTechApp_Final_Project/models/employee_model.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/screen/checkin_page.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/screen/checkin_scan_page.dart';
import 'package:BTechApp_Final_Project/presentation/home/screen/home_page.dart';

import 'package:BTechApp_Final_Project/presentation/login/cubit/cubit.dart';
import 'package:BTechApp_Final_Project/presentation/login/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTechApp',
      theme: ThemeData(

        snackBarTheme: SnackBarThemeData(
          backgroundColor: BgaColor.bgaOrange,
          actionTextColor: BgaColor.bgaWhiteA700,
          contentTextStyle: BgaTextStyle.buttonBGATextPrimary,
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(),
        child: LoginView(),
      ),
      routes: {
        '/home': (context) => HomePage(user: ModalRoute.of(context)?.settings.arguments as User),
        '/login': (context) => LoginView(),
        '/checkin_scan': (context) =>CheckInPage(),
        '/checkin_scanner': (context) =>QRScanner(),

      },
    );
  }
}
