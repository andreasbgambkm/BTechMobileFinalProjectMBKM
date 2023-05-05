

import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/models/checkin_model.dart';
import 'package:BTechApp_Final_Project/widgets/custom_appbar.dart';
import 'package:BTechApp_Final_Project/widgets/custom_button.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckInPage extends StatefulWidget {

  final String? title;
  final List<String>? items;



   CheckInPage({Key? key, this.title, this.items})
      : super(key: key);


  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  String _result = '';


  @override
  void initState() {
    super.initState();


  }

  int checkInCount = main_checkin_list.length;

  static List<CheckInModel> main_checkin_list =[

   CheckInModel("Abdan Ma'ruf", '36112005', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Andreas Magang BGA", '36112006', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Ciko Jeriko", '36112007', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Pak Alan", '36112008', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Zahra Magang BGA", '36112005', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Riyan Magang BGA", '36112006', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Abdan Ma'ruf", '36112005', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Andreas Magang BGA", '36112006', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Ciko Jeriko", '36112007', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Pak Alan", '36112008', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Zahra Magang BGA", '36112005', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Riyan Magang BGA", '36112006', DateTime.now(), '', 'CheckIn'),
    CheckInModel("Erik  BGA", '36112019', DateTime.now(), '', 'CheckIn'),


  ];

  List<CheckInModel> display_list = List.from(main_checkin_list);
  void updateList(String value){
    setState(() {
      display_list = main_checkin_list.where((element) => element.name.toLowerCase().contains(value.toLowerCase()) ||  element.nik.toLowerCase().contains(value.toLowerCase())).toList() ;
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


           const SizedBox(height: 20.0,),

            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  Text("$checkInCount Orang Pekerja"
                  , style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,

                    ),),
                ],
              ),
            ),

            TextField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: BgaColor.bgaSearchBarColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none
                ),
                hintText: 'Siapa Yang Anda Cari?',
                prefixIcon: Icon(FlutterIcons.search1_ant),
                prefixIconColor: BgaColor.bgaGray200,
              ),

            ),
            SizedBox(height: 20.0,),

            Expanded(
              child: ListView.builder(
                itemCount: display_list.length,
                itemBuilder: (context, index) {
                  return Card(
                    borderOnForeground: true,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                             display_list[index].name,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                // aksi yang akan dilakukan ketika teks di klik
                              },
                              child: Text(
                                display_list[index].label,
                                style: TextStyle(

                                  color: BgaColor.bgaBlack90001,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                        child: Row(
                          children: <Widget> [
                            const Text(
                            "NIK  ",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),

                            Text(
                              display_list[index].nik,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('HH:mm').format(display_list[index].checkin_time!).toString(),

                              style:  TextStyle(
                                  backgroundColor: BgaColor.bgaLightGreenList,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),


                          ],
                        ),
                      ),
                      onTap: () {

                      },
                    ),
                  );
                },
              ),
            ),

           const  SizedBox(height: 10,),

            BgaButton(text: 'Cetak',

                onPressed:(){

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
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: SizedBox(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Easy Permission Validator Demo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
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
                          label: Text('Cancel'),
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