import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/models/employee_model.dart';
import 'package:BTechApp_Final_Project/repository/EmployeeRepository.dart';
import 'package:BTechApp_Final_Project/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:BTechApp_Final_Project/widgets/custom_card.dart';
import 'package:BTechApp_Final_Project/widgets/custom_searchbar.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInPage extends StatefulWidget {

  final String? title;
  final List<String>? items;

  const  CheckInPage({Key? key, this.title, this.items})
      : super(key: key);


  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  String _result = '';

  List<Employee> checkInList =[];
  final EmployeeRepository repository = EmployeeRepository();
  int checkInCount = 0;

  Future<void> getAllCheckInModels() async {
    final list = await repository.getAllCheckInModels();
    setState(() {
      checkInList = list;
      checkInCount = checkInList.length;

    });
    updateList("");
  }

  @override
  void initState() {
    super.initState();
    getAllCheckInModels();

  }



  EmployeeRepository _employeeRepository = EmployeeRepository();


  updateList(String value) async {
    final list = await repository.getAllCheckInModels();
    setState(() {
      if (value.isEmpty) {
        // Jika value kosong, tampilkan semua item
        checkInList = list;
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
      appBar: CustomAppBar(title: 'Daftar Pekerja'),
      body: Padding(
        padding: BgaPaddingSize.getPaddingBody(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            BgaButton(text: 'Scan CheckIn',
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
                  Text("$checkInCount Orang Pekerja", style: BgaTextStyle.titleBoldText),
                ],
              ),
            ),
            
            BgaCustomSearchBar(onChanged: (value){updateList(value);}),

            SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),

            Expanded(
              child: ListView.builder(
                itemCount: checkInCount,
                itemBuilder: (context, index) {

                  return CustomCardCheckIn(name:  checkInList[index].name, isCheckedIn: checkInList[index].isCheckedIn, onTap: (){}, nik: checkInList[index].nik,);
                  // return Card(
                  //   borderOnForeground: true,
                  //   elevation: 2,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  //   child: ListTile(
                  //     title: Padding(
                  //       padding: const EdgeInsets.only(bottom: 8.0),
                  //       child: Row(
                  //         children: <Widget>[
                  //           Text(
                  //            checkInList[index].name,
                  //             style:BgaTextStyle.titleBoldText) ,
                  //           const Spacer(),
                  //           InkWell(
                  //             onTap: () {
                  //               // aksi yang akan dilakukan ketika teks di klik
                  //             },
                  //             child: Text(
                  //               checkInList[index].isCheckedIn.toString(),
                  //               style: BgaTextStyle.subtitleText
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //
                  //     subtitle: Padding(
                  //       padding: BgaPaddingSize.getPaddingNikInCheckIn(),
                  //       child: Row(
                  //         children: <Widget> [
                  //            Text(
                  //           "NIK  ",
                  //             style:BgaTextStyle.titleNormalText,
                  //           ),
                  //
                  //           Text(
                  //             checkInList[index].nik,
                  //             style: BgaTextStyle.titleNormalText
                  //           ),
                  //           const Spacer(),
                  //           Text(
                  //             DateFormat('HH:mm').format(DateTime.now()).toString(),
                  //             style:  BgaTextStyle.subtitleBoldText,
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //     onTap: () {
                  //
                  //     },
                  //   ),
                  // );
                },
              ),
            ),

           SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight(),),

            BgaButton(text: 'Cetak',

                onPressed:() {

            })
          ],
        ),
      ),
    );
  }

  _permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
     appName: 'Easy Permission Validator',
    );
    var result = await permissionValidator.camera();
    if (result) {
      setState(() => _result = 'Permission accepted');
    }
  }

  _permissionWithCustomPopup() async {
    EasyPermissionValidator permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
      customDialog: MyAmazingCustomPopup(),
    );
    var result = await permissionValidator.camera();
    if (result) {
      setState(() => _result = 'Permission accepted');
    }
  }
}

class MyAmazingCustomPopup extends StatefulWidget {
  @override
  _MyAmazingCustomPopupState createState() => _MyAmazingCustomPopupState();
}

class _MyAmazingCustomPopupState extends State<MyAmazingCustomPopup> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Padding(
          padding: BgaPaddingSize.getBgaPaddingSymmHorizontal13(),
          child: SizedBox(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.bgaroundedBorder15,
              ),
              color: Colors.white,
              child: Padding(
                padding: BgaPaddingSize.getBgaPaddingSymmetric20(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Easy Permission Validator Demo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   const  Icon(
                      Icons.perm_camera_mic,
                      size: 60.0,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () => _closePopup(),
                          icon: Icon(Icons.cancel),
                          label: const Text('Cancel'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _openPermissionSettings(),
                          icon: Icon(Icons.arrow_forward_ios),
                          label: Text('Go To Settings'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _openPermissionSettings() async {
    await openAppSettings();
    _closePopup();
  }

  _closePopup() {
    Navigator.of(context).pop();
  }
}