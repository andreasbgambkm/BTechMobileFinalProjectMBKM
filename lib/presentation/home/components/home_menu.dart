import 'package:BTechApp_Final_Project/presentation/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BlocBuilder<CheckInCubit, CheckInState>(
              builder: (context, state) {
                return CustomCardMenu(
                  title: 'CheckIn',
                  counter: state.checkInList.length,
                  route: '/checkin',
                );
              },
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
