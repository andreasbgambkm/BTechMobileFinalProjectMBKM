import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/constant.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_alert.dart';
import 'package:flutter/material.dart';

class CustomCardGps extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconLocation;
  final double? width;
  final double? height;
  final String? weather;
  final IconData iconWeather;


  const CustomCardGps({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconLocation,
    required this.iconWeather,
    this.width = 50.0,
    this.height = 30.0,
    this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          iconLocation,
          size: width != null && height != null ? (width! + height!) / 2 : null,
          color: BgaColor.bgaOrange,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          iconWeather,
          color: BgaColor.bgaOrange,
        ),
        onTap: () {
          // Aksi yang akan dilakukan ketika card ditekan
        },
      ),
    );
  }
}

class CustomCardRkh extends StatelessWidget {
  final String title;
  final List<String> subtitle;
  final double? width;
  final double? height;
  final List<int?> counter;

  const CustomCardRkh({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.counter,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              Text(
                title,
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
                  'Lihat Semua',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: subtitle
                    .asMap()
                    .map((index, item) =>
                    MapEntry(
                        index,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${counter[index]}',
                              style: TextStyle(
                                background: Paint()
                                  ..color =
                                      BgaColor.bgaOrange
                                  ..strokeWidth = 20
                                  ..strokeJoin = StrokeJoin.round
                                  ..strokeCap = StrokeCap.round
                                  ..style = PaintingStyle.stroke,
                                color: BgaColor.bgaWhiteA700,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              item,
                              style: TextStyle(
                                background: Paint()
                                  ..color = BgaColor.bgaOrangeBottomNavigation
                                  ..strokeWidth = 20
                                  ..strokeJoin = StrokeJoin.round
                                  ..strokeCap = StrokeCap.round
                                  ..style = PaintingStyle.stroke,
                                color: BgaColor.bgaBlack90001,
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                          ],
                        )))
                    .values
                    .toList(),
              ),
              const SizedBox(
                width: 100,
                height: 10,
              ),
            ],
          ),
        ),
        onTap: () {
          // Aksi yang akan dilakukan ketika card ditekan
        },
      ),
    );
  }
}

class CustomCardMenu extends StatelessWidget {


  final String title;
  final int counter;
  final double? width;
  final double? height;
  final String? route;


  const CustomCardMenu({
    Key? key,
    required this.title,
    required this.counter,
    this.width = 175,
    this.height = 110,
    this.route,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.bgaroundedBorder15,

        ),
        child: ListTile(

          title: Text(title,
            style: BgaTextStyle.titleBoldText,

          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(counter.toString(),
                    style: BgaTextStyle.homeCounterCardText),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                      'Orang', style: BgaTextStyle.homeCounterPersonText),
                ),
              ],
            ),
          ),

          onTap: () {
            Navigator.pushNamed(context, '$route');
          },
        ),
      ),
    );
  }
}

class CustomCardCheck extends StatefulWidget {

  final String name;
  final String label;
  final VoidCallback onTap;
  final String nik;
  final String notes;
  String checkTime;
  final bool isCheckout;
  final int? id;
  final bool isAssisted;

  bool isAssistanceChecked;

  CustomCardCheck({
    required this.name,
    required this.label,
    required this.onTap,
    required this.nik,
     this.notes='',
    this.isCheckout = false,
    this.checkTime ='',
    this.id,
    this.isAssisted = false,
    this.isAssistanceChecked = false

  });

  @override
  _CustomCardCheckState createState() => _CustomCardCheckState();
}
class _CustomCardCheckState extends State<CustomCardCheck> {
  int? id;
  bool isChecked = false; // State untuk CheckBox

  void _handleTap() {
    setState(() {
      widget.isAssistanceChecked = !widget.isAssistanceChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    DateTime checkInTimeLimiter = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      8,
      0,
    );

    bool isLateCheckIn = currentTime.isAfter(checkInTimeLimiter);

    Color labelBackgroundColor = isLateCheckIn ? BgaColor.bgaLightRedList : BgaColor.bgaLightGreen100;

    return Card(
      borderOnForeground: true,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.bgaroundedBorder15,
        side: BorderSide(width: 1, color: BgaColor.bgaOrange),
      ),
      child: InkWell(
        onTap: (){
          _handleTap();
          widget.onTap;
        }


        ,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(
                    widget.name,
                    style: BgaTextStyle.titleBoldText,
                  ),
                  Text(
                    widget.label,
                    style: BgaTextStyle.titleBoldText,
                  ),
                ],
              ),
              SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
              SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "NIK  ${widget.nik}",
                    style: BgaTextStyle.titleBoldText,
                  ),
                  if (widget.label == 'Check In' || widget.label == 'Check Out')
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusStyle.bgaroundedBorder15,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: labelBackgroundColor,
                          padding:
                          BgaPaddingSize.getBgaPaddingBackgroundColorCheckinTime(),
                          child: Text(
                            widget.checkTime,
                            style: BgaTextStyle.subtitleText2,
                          ),
                        ),
                      ),
                    ),

                  if (widget.isAssisted) // Tampilkan CheckBox hanya jika isAssisted true
                    Theme(
                      data: Theme.of(context).copyWith(
                        checkboxTheme: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusStyle.roundedBorder5, // Atur radius sudut sesuai keinginan Anda
                          ),
                        ),
                      ),
                      child: Checkbox(
                        value: widget.isAssistanceChecked,
                        onChanged: (value) {
                          setState(() {
                            widget.isAssistanceChecked;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith((states) => BgaColor.bgaOrange), // Atur warna checklist sesuai keinginan Anda
                      ),
                    )

                ],
              ),
              Row(
                children: <Widget>[
                  if (widget.label == 'Check Out')
                    Text(
                      "Notes :",
                      style: BgaTextStyle.homeCounterPersonText,
                    ),
                ],
              ),
              SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight()),
              if (widget.label == 'Check Out')
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: BgaColor.bgaBlueGray400),
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: BgaPaddingSize.getPaddingBottom8(),
                          child: TextField(
                            enabled: false,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              labelText: "${widget.notes}",
                              labelStyle: BgaTextStyle.searchBarText,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                            ),
                          ),
                        ),
                      ),
                      if (widget.isCheckout)
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showCommentDialog();
                          },
                        ),
                    ],
                  ),
                ),
              SizedBox(height: BgaSizedboxSize.getSizedBoxMidHeight()),
            ],
          ),
        ),
      ),
    );
  }

  void _showCommentDialog() {
    if (widget.id != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BgaAddNotes(
            id: widget.id!,
            img: Image.asset(imageAlertDefault),
          );
        },
      );
    }
  }
}
