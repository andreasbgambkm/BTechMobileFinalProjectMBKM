import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/checkout/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:BTechApp_Final_Project/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:BTechApp_Final_Project/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';

class CheckOutPage extends StatefulWidget {
  final String? title;
  final List<String>? items;

  const CheckOutPage({Key? key, this.title, this.items}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}
class _CheckOutPageState extends State<CheckOutPage> {
  final String routeName = "/checkout_scanner";
  late final CheckOutCubit checkOutCubit;


  void printCheckOuts() {
    checkOutCubit.stream.listen((state) {
      if (state is CheckOutSuccess) {
        print('Successful Check-Outs:');
        state.checkoutList.forEach((checkOut) {
          print('Name: ${checkOut.name}');
          print('NIK: ${checkOut.nik}');
          print('Check-Out Time: ${checkOut.checkoutTime}');
          print('Notes: ${checkOut.note}');
          print('---');
        });
      } else if (state is CheckOutLoading) {
        print('Loading...');
      }
    });
  }
  @override
  void initState() {
    super.initState();
    checkOutCubit = context.read<CheckOutCubit>();
    checkOutCubit.getAllSuccessfulCheckedOut();
    printCheckOuts();
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
      body: Padding(
        padding: BgaPaddingSize.getPaddingBody(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BgaButton(
              text: buttonScanCheckOut,
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
                  BlocConsumer<CheckOutCubit, CheckOutState>(
                    listener: (context, state) {
                      // Add any listener logic if needed
                    },
                    builder: (context, state) {
                      return Text(
                        "${state.checkoutCount} $counterAttendanceOnEmployeeList",
                        style: BgaTextStyle.titleBoldText,
                      );
                    },
                  ),
                ],
              ),
            ),
            BgaCustomSearchBar(
              onChanged: (value) {
                context.read<CheckOutCubit>().updateList(value);
              },
            ),
            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
            Expanded(
              child: BlocConsumer<CheckOutCubit, CheckOutState>(
                listener: (context, state) {
                  // Add any listener logic if needed
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator(color: BgaColor.bgaOrange,));
                  } else if (state.isEmpty) {
                    return ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children:<Widget> [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              imageEmptyList,
                              width: 200,
                              height: 200,
                            ),

                            SizedBox(height: BgaSizedboxSize.getSizedBoxLowHeight(),),
                            Text(textEmptyList,
                              style: BgaTextStyle.subtitleText2,),
                          ],
                        ),


                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.checkoutCount,
                      itemBuilder: (context, index) {
                        final CheckOut = state.checkoutList[index];

                        return CustomCardCheck(
                          id: CheckOut.id,
                          name: CheckOut.name,
                          label: 'Check Out',
                          onTap: () {},
                          nik: CheckOut.nik,
                          notes: CheckOut.note,
                          isCheckout: true,
                          checkinTime: CheckOut.checkoutTime,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight()),
            BgaButton(
              text: buttonPrint,
              onPressed: () async {

              },
            ),
          ],
        ),
      ),
    );
  }
}
