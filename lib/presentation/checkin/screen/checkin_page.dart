import 'dart:async';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'package:BTechApp_Final_Project/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:BTechApp_Final_Project/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';

class CheckInPage extends StatefulWidget {
  final String? title;
  final List<String>? items;

  const CheckInPage({Key? key, this.title, this.items}) : super(key: key);

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final String routeName = "/checkin_scanner";
  late final CheckInCubit checkInCubit;

  @override
  void initState() {
    super.initState();
    checkInCubit = context.read<CheckInCubit>();
    checkInCubit.startAutoDeleteTimer();
    checkInCubit.getAllSuccessfulCheckedIn();
  }

  @override
  void dispose() {
    checkInCubit.cancelAutoDeleteTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgaColor.bgaBodyColor,
      appBar: CustomAppBar(title: appBarTitleOnEmployeeList),
      body: Padding(
        padding: BgaPaddingSize.getPaddingBody(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BgaButton(
              text: buttonScanCheckIn,
              icon: FlutterIcons.barcode_ant,
              backgroundColor: BgaColor.bgaWhiteA700,
              textColor: BgaColor.bgaOrange,
              onPressed: () {
                Navigator.pushNamed(context, routeName);
              },
            ),
            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
            Padding(
              padding: BgaPaddingSize.getPaddingRowCounterPekerja(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  BlocBuilder<CheckInCubit, CheckInState>(
                    builder: (context, state) {
                      if (state is CheckInSuccess) {
                        return Text(
                          "${state.checkInList.length} $counterAttendanceOnEmployeeList",
                          style: BgaTextStyle.titleBoldText,
                        );
                      } else {
                        return Text(
                          "0 $counterAttendanceOnEmployeeList",
                          style: BgaTextStyle.titleBoldText,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            BgaCustomSearchBar(
              onChanged: (value) {
                checkInCubit.updateList(value);
              },
            ),
            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
            Expanded(
              child: BlocBuilder<CheckInCubit, CheckInState>(
                builder: (context, state) {
                  if (state is CheckInLoading) {
                    return CircularProgressIndicator();
                  } else if (state is CheckInEmpty) {
                    return ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imageEmptyList,
                              width: 200,
                              height: 200,
                            ),
                            SizedBox(height: BgaSizedboxSize.getSizedBoxLowHeight()),
                            Text(
                              textEmptyList,
                              style: BgaTextStyle.subtitleText2,
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is CheckInSuccess) {
                    return ListView.builder(
                      itemCount: state.checkInList.length,
                      itemBuilder: (context, index) {
                        final checkIn = state.checkInList[index];
                        return CustomCardCheck(
                          name: checkIn.name,
                          isChecked: checkIn.isCheckedIn,
                          onTap: () {},
                          nik: checkIn.nik,
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight()),
            BgaButton(
              text: buttonPrint,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
