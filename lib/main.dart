import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/login_data.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/screen/checkin_page.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/screen/checkin_scan_page.dart';
import 'package:BTechApp_Final_Project/presentation/checkout/cubit/checkout_cubit/checkout_cubit_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/checkout/screen/checkout_page.dart';
import 'package:BTechApp_Final_Project/presentation/home/screen/home_page.dart';
import 'package:BTechApp_Final_Project/presentation/login/cubit/cubit.dart';
import 'package:BTechApp_Final_Project/presentation/login/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/checkin/cubit/checkin_cubit/checkin_cubit.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<CheckInCubit>(create: (context) => CheckInCubit()),
        BlocProvider<CheckOutCubit>(create: (context)=> CheckOutCubit()),
      ],
      child: MaterialApp(
        title: 'SPARTA (Sistem Perkebunan Area Bumitama)',
        theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            backgroundColor: BgaColor.bgaOrange,
            actionTextColor: BgaColor.bgaWhiteA700,
            contentTextStyle: BgaTextStyle.buttonBGATextPrimary,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginView(),
        routes: {
          '/home': (context) => HomePage(user: ModalRoute.of(context)?.settings.arguments as User),
          '/login': (context) => const LoginView(),
          '/checkin': (context) => const CheckInPage(),
          '/checkin_scanner': (context) => const QRScanner(),
          '/checkout': (context) => const CheckOutPage(),
        },
      ),
    );
  }
}
