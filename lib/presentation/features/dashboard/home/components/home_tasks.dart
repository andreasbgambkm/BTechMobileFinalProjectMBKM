import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:flutter/material.dart';

class HomeTasks extends StatefulWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  _HomeTasksState createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  List<String> tasks = [
    'Download Master Data',
    'CheckIn',
    'CheckOut',
    'Asistensi',
  ];
  List<bool> values = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tasks',
            style: TextStyle(fontFamily: 'Poppins',fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey);
            },

            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.all(2.0),
                activeColor: BgaColor.bgaOrange,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(tasks[index], style: TextStyle(fontFamily: 'Poppins',fontSize: 14,
                    fontWeight: FontWeight.normal),),
                value: values[index],
                onChanged: (newValue) {
                  setState(() {
                    values[index] = newValue!;
                  });
                },
              );

            },

          ),


        ],
      ),
    );
  }
}
