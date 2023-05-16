
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column (

        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget> [
              CustomCardMenu(
                title: 'CheckIn',
                counter: 100,
                route: '/checkin_scan',
               ),
              CustomCardMenu(title: 'CheckOut', counter: 15, route: '/coba_screen',),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomCardMenu(title: 'Asistensi Masuk', counter: 2),
              CustomCardMenu(title: 'Asistensi Keluar', counter: 4),
            ],
          )

        ],
      ),
    );
  }
}
