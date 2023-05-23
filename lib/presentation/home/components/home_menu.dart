
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column (

      children: <Widget> [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget> [
            CustomCardMenu(
              title: 'CheckIn',
              counter: 100,
              route: '/checkin',
             ),
            CustomCardMenu(title: 'CheckOut', counter: 15, route: '/checkout',),
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
    );
  }
}
