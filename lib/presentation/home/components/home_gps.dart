
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';

class HomeGps extends StatelessWidget {
  const HomeGps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: BgaPaddingSize.getPaddingGpsCard(),
      child:  const CustomCardGps(
        title: 'SBSE-Sungai Bahaur Estate',
        subtitle: 'Lokasi Anda Saat Ini',
        iconLocation: Icons.location_on_outlined,
        iconWeather:FlutterIcons.weather_lightning_rainy_mco,
        width: 30.0,
        height: 50.0,
      ),
    );
  }
}
