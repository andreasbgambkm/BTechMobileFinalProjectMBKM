import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    this.width =50.0,
    this.height = 30.0 ,
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
                    .map((index, item) => MapEntry(
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
    this.width =156,
    this.height = 94,
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
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(

          title: Text(title,
            style: BgaTextStyle.titleBoldText,

                ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top:10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(counter.toString(),
                  style:BgaTextStyle.homeCounterCardText),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text('Orang', style: BgaTextStyle.homeCounterPersonText),
                ),
              ],
            ),
          ),

          onTap: () {
            Navigator.pushNamed(context,'$route');
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
  final String? notes;
  final String checkinTime;
  final bool isCheckout;

  const CustomCardCheck({
    required this.name,
    required this.label,
    required this.onTap,
    required this.nik,
    this.notes,
    this.isCheckout = false,
    required this.checkinTime,
  });

  @override
  _CustomCardCheckState createState() => _CustomCardCheckState();
}

class _CustomCardCheckState extends State<CustomCardCheck> {
  String? _notes;

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
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              Text(
                widget.name,
                style: BgaTextStyle.titleBoldText,
              ),
              const Spacer(),
              InkWell(
                onTap: widget.onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: labelBackgroundColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.label,
                    style: BgaTextStyle.subtitleText,
                  ),
                ),
              ),
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            children: <Widget>[
              Text(
                "NIK  ",
                style: BgaTextStyle.titleBoldText,
              ),
              Text(
                widget.nik,
                style: BgaTextStyle.subtitleText,
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: labelBackgroundColor,
                  borderRadius: BorderRadiusStyle.bgaroundedBorder15, // Mengatur radius background
                ),
                child: Text(
                  widget.checkinTime,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: BgaColor.bgaBlack900,
                  ),
                ),
              ),

              if (widget.isCheckout) // Tampilkan kolom komentar hanya jika isCheckout bernilai true
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showCommentDialog();
                  },
                ),
            ],
          ),
        ),
        onTap: widget.onTap,
        trailing: _notes != null && _notes!.isNotEmpty
            ? Column(
          children: [
            const Divider(),
            Expanded(
              child: ListTile(
                title: Text(
                  "Catatan:",
                  style: BgaTextStyle.subtitleText,
                ),
                subtitle: Text(
                  _notes!,
                  style:  BgaTextStyle.subtitleText,
                ),
              ),
            ),
          ],
        )
            : null,
      ),
    );
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambahkan Komentar'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _notes = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Masukkan komentar...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
