import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/repositories/checkin_repository.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/checkout/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {

  int checkInCounter = 0;
  final CheckInRepository checkInRepository = CheckInRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            BlocBuilder<CheckOutCubit, CheckOutState>(
              builder: (context, state) {
                return CustomCardMenu(
                  title: 'CheckOut',
                  counter: state.checkoutList.length,
                  route: '/checkout',);
              },
            ),
          ],
        ),
        SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CustomCardMenu(title: 'Asistensi Masuk', counter: 2),
            CustomCardMenu(title: 'Asistensi Keluar', counter: 4),
          ],
        )

      ],
    );
  }


}
