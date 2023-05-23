
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

// class CustomCardCheck extends StatelessWidget {
//   final String name;
//   final String nik;
//   final DateTime checkin_time;
//   final String? note;
//   final String label;
//
//
//    CustomCardCheck(
//       {super.key, required this.name, required this.nik, required this.checkin_time, this.note, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       borderOnForeground: true,
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListTile(
//         title: Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: Row(
//             children: <Widget>[
//               Text(
//                 name,
//                 style: const TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               ),
//               const Spacer(),
//               InkWell(
//                 onTap: () {
//                   // aksi yang akan dilakukan ketika teks di klik
//                 },
//                 child: Text(
//                   label,
//                   style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     color: BgaColor.bgaBlack90001,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 18.0, bottom: 8),
//           child: Row(
//             children: <Widget> [
//               Text(
//                 "NIK $nik,",
//                 style: const TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 14,
//                     fontWeight: FontWeight.normal),
//               ),
//               const Spacer(),
//               Text(
//                 checkin_time.toString(),
//                 style: const TextStyle(
//                   backgroundColor: Color.fromARGB(255, 233, 228, 1),
//                     fontFamily: 'Poppins',
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal),
//               ),
//
//
//             ],
//           ),
//         ),
//         onTap: () {
//           // Aksi yang akan dilakukan ketika card ditekan
//         },
//       ),
//     );
//   }
// }

class CustomCardCheck extends StatelessWidget {
  final String name;
  final int isChecked;
  final VoidCallback onTap;
  final String nik;
  final String? notes;

  const CustomCardCheck({
    required this.name,
    required this.isChecked,
    required this.onTap,
    required this.nik,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
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
                name,
                style: BgaTextStyle.titleBoldText,
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Text(
                  isChecked.toString(),
                  style: BgaTextStyle.subtitleText,
                ),
              ),
            ],
          ),
        ),
        subtitle: Padding(
          padding: BgaPaddingSize.getPaddingNikInCheckIn(),
          child: Row(
            children: <Widget>[
              Text(
                "NIK  ",
                style: BgaTextStyle.titleNormalText,
              ),
              Text(
                nik,
                style: BgaTextStyle.titleNormalText,
              ),
              const Spacer(),
              Text(
                DateFormat('HH:mm').format(DateTime.now()).toString(),
                style: BgaTextStyle.subtitleBoldText,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Aksi ketika tombol pensil di klik
                  // Tambahkan logika untuk menampilkan kolom catatan
                },
              ),
            ],
          ),
        ),
        onTap: onTap,
        trailing: notes != null && notes!.isNotEmpty
            ? Column(
          children: [
            const Divider(),
            Expanded(
              child: ListTile(
                title: Text(
                  "Catatan:",
                  style: BgaTextStyle.titleBoldText,
                ),
                subtitle: Text(
                  notes!,
                  style: BgaTextStyle.titleNormalText,
                ),
              ),
            ),
          ],
        )
            : null,
      ),
    );
  }
}

