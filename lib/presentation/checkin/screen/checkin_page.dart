import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/checkin/cubit/checkin_scan_cubit/scan_checkin_cubit.dart';
import 'package:BTechApp_Final_Project/widgets/custom_alert.dart';
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
  String? qrInit;

  @override
  void initState() {
    super.initState();
    checkInCubit = context.read<CheckInCubit>();
    checkInCubit.getAllSuccessfulCheckedIn();
    printCheckIns();
  }

  void printCheckIns() {
    checkInCubit.stream.listen((state) {
      if (state is CheckInSuccess) {
        print('Successful Check-Ins:');
        state.checkInList.forEach((checkIn) {
          print('Name: ${checkIn.name}');
          print('NIK: ${checkIn.nik}');
          print('Check-in Time: ${checkIn.checkInTime}');
          print('---');
        });
      } else if (state is CheckInLoading) {
        print('Loading...');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgaColor.bgaBodyColor,
      appBar: CustomAppBar(title: appBarTitleOnEmployeeList),
      body: BlocListener<ScanCheckinCubit, ScanCheckinState>(
        listener: (context, state) {
          if (state is ScanCheckinSuccess) {
            showDialog(context: context,
                builder: (BuildContext context){
                  return BgaCustomAlert(
                    title: 'Check-In Berhasil',
                    descriptions: 'Pekerja dengan NIK ${state.employee.nik} - ${state.employee.name} berhasil check-in.',
                    text: "OK",
                    img: Image.asset(imageAlertSuccess),
                  );
                }
            );

            context.read<CheckInCubit>().getAllSuccessfulCheckedIn();
          }
        },
        child: Padding(
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
                      return const Center(child: CircularProgressIndicator(color: Colors.deepOrange));
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
                          return Padding(
                            padding: BgaPaddingSize.getPaddingBottom8(),
                            child: CustomCardCheck(
                              name: checkIn.name,
                              label: 'Check In',
                              onTap: () {},
                              nik: checkIn.nik,
                              checkinTime: checkIn.checkInTime,
                              isCheckout: false,
                            ),
                          );
                        },

                      );
                    } else {
                      return Container(
                        child: Center(child: CircularProgressIndicator(color: Colors.deepOrange)),
                      );
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
      ),
    );
  }
}
