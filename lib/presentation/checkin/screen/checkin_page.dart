import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/models/checkin_model.dart';
import 'package:BTechApp_Final_Project/models/employee_model.dart';
import 'package:BTechApp_Final_Project/repository/EmployeeRepository.dart';
import 'package:BTechApp_Final_Project/repository/checkin_repository.dart';
import 'package:BTechApp_Final_Project/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:BTechApp_Final_Project/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class CheckInPage extends StatefulWidget {

  final String? title;
  final List<String>? items;

  const  CheckInPage({Key? key, this.title, this.items})
      : super(key: key);


  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {


  List<CheckInModel> checkInList =[];
  final EmployeeRepository repository = EmployeeRepository();

  final CheckInRepository checkInRepository = CheckInRepository();
  int checkInCount = 0;

  Future<void> getAllSuccessfulCheckedIn() async{

    final list = await checkInRepository.getAllSuccessfulCheckIns();

    setState(() {
      checkInList = list;
      checkInCount = checkInList.length;
    });
    updateList('');
  }

  // Future<void> getAllCheckInModels() async {
  //   final list = await repository.getAllCheckInModels();
  //   setState(() {
  //     checkInList = list;
  //     checkInCount = checkInList.length;
  //
  //   });
  //   updateList("");
  // }

  @override
  void initState() {
    super.initState();
    // getAllCheckInModels();
    getAllSuccessfulCheckedIn();

  }



  EmployeeRepository _employeeRepository = EmployeeRepository();


  updateList(String value) async {
    final list = await checkInRepository.getAllSuccessfulCheckIns();
    setState(() {
      if (value.isEmpty) {
        // Jika value kosong, tampilkan list kosong
        checkInList = list.isNotEmpty ? list : [];
      } else {
        // Jika value tidak kosong, filter item berdasarkan kondisi
        checkInList = list.where((element) => element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.nik.toLowerCase().contains(value.toLowerCase())).toList();
      }
      checkInCount = checkInList.length; // tambahkan pembaruan jumlah item di sini
    });
  }



  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final String routeName = "/checkin_scanner";

    return Scaffold(
      backgroundColor: BgaColor.bgaBodyColor,
      appBar: CustomAppBar(title: appBarTitleOnCheckInList),
      body: Padding(
        padding: BgaPaddingSize.getPaddingBody(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            BgaButton(text: buttonScanCheckIn,
                icon: FlutterIcons.barcode_ant,
                backgroundColor: BgaColor.bgaWhiteA700,
                 textColor: BgaColor.bgaOrange,
              onPressed: () {
              Navigator.pushNamed(context, routeName);
              },
            ),

            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),

            Padding(
              padding: BgaPaddingSize.getPaddingRowCounterPekerja(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  Text("$checkInCount $counterAttendanceOnEmployeeList", style: BgaTextStyle.titleBoldText),
                ],
              ),
            ),
            
            BgaCustomSearchBar(onChanged: (value){updateList(value);}),

            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),

            Expanded(
              child: ListView.builder(
                itemCount: checkInCount,
                itemBuilder: (context, index) {

                  return CustomCardCheckIn(
                    name:  checkInList[index].name,
                    isCheckedIn: checkInList[index].isCheckedIn,
                    onTap: (){},
                    nik: checkInList[index].nik,);

                },
              ),
            ),

           SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight(),),

            BgaButton(text: buttonPrint,

                onPressed:() {

            })
          ],
        ),
      ),
    );
  }



}
