import 'package:BTechApp_Final_Project/core/app_expor.dart';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/data/models/assistance_out_model.dart';
import 'package:BTechApp_Final_Project/data/models/checkin_model.dart';
import 'package:BTechApp_Final_Project/data/models/division_model.dart';
import 'package:BTechApp_Final_Project/data/models/estate_model.dart';
import 'package:BTechApp_Final_Project/data/models/kemandoran_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/division_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/estate_repository.dart';
import 'package:BTechApp_Final_Project/data/repositories/kemandoran_repository.dart';
import 'package:BTechApp_Final_Project/presentation/features/assistance/assistance_out/cubit/assistance_out_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/checkin/cubit/checkin_cubit/checkin_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/features/attendance/checkin/cubit/checkin_scan_cubit/scan_checkin_cubit.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_alert.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_button.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_card.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_searchbar.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AssistanceOut extends StatefulWidget {
  const AssistanceOut({Key? key}) : super(key: key);

  @override
  State<AssistanceOut> createState() => _AssistanceOutState();


}

class _AssistanceOutState extends State<AssistanceOut> {
  final EstateRepository estateRepository = EstateRepository();
  final DivisionRepository divisionRepository = DivisionRepository();
  final KemandoranRepository kemandoranRepository = KemandoranRepository();
  late final CheckInCubit checkInCubit;
  bool isAssistanceChecked = true;
  late List<AssistanceOut> selectedAssist;
  late int isAssistanceCounter;
  late AssistanceOutCubit assistanceOutCubit;


  @override
  void initState() {
    super.initState();
    checkInCubit = context.read<CheckInCubit>();
    checkInCubit.getAllSuccessfulCheckedIn();
    isAssistanceChecked = false;
    selectedAssist = [];
    isAssistanceCounter = 0;
    assistanceOutCubit = AssistanceOutCubit();

  }


  @override
  void dispose() {
    assistanceOutCubit.close();
    super.dispose();
  }


  void toggleSelectAssistanceOut(String assistanceOut) {
    if (selectedAssist.contains(assistanceOut)) {
      setState(() {
        selectedAssist.remove(assistanceOut);
        isAssistanceCounter--;
      });
    } else {
      setState(() {
        // selectedAssist.add(assistanceOut);
        isAssistanceCounter++;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanCheckinCubit, ScanCheckinState>(
      listener: (context, state) {
        if (state is ScanCheckinSuccess) {
          showDialog(context: context,
              builder: (BuildContext context){
                return BgaCustomAlert(
                  title: 'Check-In Berhasil',
                  descriptions: 'Pekerja dengan NIK ${state.employee.nik} - ${state.employee.name} Siap di-asistensikan.',
                  text: "OK",
                  img: Image.asset(imageAlertSuccess),
                );
              }
          );

          context.read<CheckInCubit>().getAllSuccessfulCheckedIn();
        }
      },
      child: Scaffold(
        backgroundColor: BgaColor.bgaBodyColor,
        appBar: CustomAppBar(title: 'Asistensi Keluar'),
        body: Padding(
          padding: BgaPaddingSize.getPaddingBody(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FutureBuilder<List<Estate>>(
                      future: estateRepository.getAllEstates(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final List<Estate> estates = snapshot.data!;
                          return BgaCustomTextFieldAndBottomSheet(

                            title: 'Tujuan Estate',
                            description: 'Pilih Tujuan Estate',
                            icon: Icons.arrow_forward,
                            itemList: estates.map((estate) =>
                            estate.id + '  ' + estate.estate).toList(),
                          );
                        } else {
                          return Text('No Data', style: BgaTextStyle.titleBoldText,);
                        }
                      },
                    ),

                    FutureBuilder<List<Division>>(
                      future: divisionRepository.getAllDivisions(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final List<Division> divisions = snapshot.data!;
                          return BgaCustomTextFieldAndBottomSheet(

                            title: 'Tujuan Divisi',
                            description: 'Pilih Tujuan Divisi',
                            icon: Icons.arrow_forward,
                            itemList: divisions.map((divisions) =>
                            divisions.id + '  ' + divisions.division).toList(),
                          );
                        } else {
                          return Text('No Data', style: BgaTextStyle.titleBoldText,);
                        }
                      },
                    ),

                    FutureBuilder<List<Kemandoran>>(
                      future: kemandoranRepository.getAllKemandorans(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final List<Kemandoran> kemandorans = snapshot.data!;
                          return BgaCustomTextFieldAndBottomSheet(

                            title: 'Tujuan Kemandoran',
                            description: 'Pilih Tujuan Kemandoran',
                            icon: Icons.arrow_forward,
                            itemList: kemandorans.map((kemandorans) =>
                            kemandorans.id + ' ' + kemandorans.kemandoran).toList(),
                          );
                        } else {
                          return Text('No Data', style: BgaTextStyle.titleBoldText,);
                        }
                      },
                    ),

                    BgaCustomSearchBar(
                        onChanged: (value) {
                          checkInCubit.updateList(value);
                        }

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
                                  "Total : ${state.checkInList.length} $counterAttendanceOnEmployeeList",
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

                    Padding(
                      padding: BgaPaddingSize.getPaddingRowCounterPekerja(),
                      child: BlocBuilder<AssistanceOutCubit, AssistanceOutState>(
                        builder: (context, state) {
                          if (state is AssistanceOutSuccess) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${state.selectedCounter} Orang Dipilih",
                                  style: BgaTextStyle.titleBoldText,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (isAssistanceCounter == 0) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Tidak Ada Pekerja Dipilih'),
                                            content: const Text(
                                              'Silakan pilih minimal satu pekerja untuk di-asistensikan.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        selectedAssist.clear();
                                        isAssistanceCounter = 0;
                                      });
                                    }


                                  },
                                  child: Text(
                                    isAssistanceCounter > 0 ? 'Hapus Semua Pilihan' : 'Pilih Semua',
                                    style: BgaTextStyle.titleBoldOrangeText,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text("Tidak Ada Pekerja Dipilih");
                          }
                        },
                      ),
                    ),




                    SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),
                    Flexible(
                      child: BlocBuilder<CheckInCubit, CheckInState>(
                        builder: (context, state) {
                          if (state is CheckInLoading) {
                            return Center(child: CircularProgressIndicator(color: BgaColor.bgaOrange));
                          } else if (state is CheckInEmpty) {
                            return Column(
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
                            );
                          } else if (state is CheckInSuccess) {
                            return Column(
                              children: List.generate(state.checkInList.length, (index) {
                                final checkIn = state.checkInList[index];

                                final assistanceOut = AssistanceOutModel(
                                    assistanceType: 'Asistensi Keluar',
                                    employeeNik: checkIn.nik,
                                    employeeName: checkIn.name,
                                    division: '',
                                    kemandoran: '',
                                    estate: '',
                                    assistanceOutTime: '',
                                    employeePosition: '');
                                return Padding(
                                  padding: BgaPaddingSize.getPaddingBottom8(),

                                  child: CustomCardCheck(
                                    isAssistanceChecked: selectedAssist.contains(checkIn),
                                    name: checkIn.name,
                                    label: 'Asistensikan',
                                    onTap: () {
                                      context.read<AssistanceOutCubit>().toggleSelectAssistanceOut(assistanceOut, selectedAssist.contains(checkIn));

                                    },
                                    nik: checkIn.nik,
                                    checkTime: checkIn.checkInTime,
                                    isCheckout: false,
                                    isAssisted: true,
                                  ),
                                );
                              }),
                            );


                          } else {
                            return Center(child: CircularProgressIndicator(color: BgaColor.bgaOrange));
                          }
                        },
                      ),
                    ),

                    SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight()),
                  ],
                ),
                SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),




              ],
            ),
          ),

        ),

        bottomSheet:  Padding(
          padding: BgaPaddingSize.getPaddingBody(),
          child: BgaButton(
            text: 'Asistensikan',
            onPressed: () {
              if(selectedAssist.isNotEmpty){

              }else{
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return BgaCustomAlert(
                        title: 'Tidak Ada Pekerja Dipilih',
                        descriptions: 'Silakan pilih minimal satu pekerja untuk di-asistensikan.',
                        text: "OK",
                        img: Image.asset(imageAlertError),
                      );
                    }

                );
              }


            },
          ),
        ),

      ),
    );
  }





}
