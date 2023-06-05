import 'package:BTechApp_Final_Project/core/app_expor.dart';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/models/login_model.dart';
import 'package:BTechApp_Final_Project/presentation/features/dashboard/home/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'presentation/features/attendance/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'presentation/features/attendance/checkin/cubit/checkin_scan_cubit/scan_checkin_cubit.dart';
import 'presentation/features/attendance/checkin/screen/checkin_page.dart';
import 'presentation/features/attendance/checkin/screen/checkin_scan_page.dart';
import 'presentation/features/attendance/checkout/cubit/checkout_cubit/checkout_cubit.dart';
import 'presentation/features/attendance/checkout/cubit/checkout_scan_cubit/scan_checkout_cubit.dart';
import 'presentation/features/attendance/checkout/screen/checkout_page.dart';
import 'presentation/features/attendance/checkout/screen/checkout_scan_page.dart';
import 'presentation/features/auth/login/cubit/cubit.dart';
import 'presentation/features/auth/login/screen/login_page.dart';
import 'presentation/features/dashboard/home/screen/home_page.dart';

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
        BlocProvider<ScanCheckinCubit>(create: (context) => ScanCheckinCubit()),
        BlocProvider<ScanCheckoutCubit>(create: (context) => ScanCheckoutCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
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
          '/checkout_scanner': (context) => const QRScannerCheckOut(),
        },
      ),
    );
  }
}