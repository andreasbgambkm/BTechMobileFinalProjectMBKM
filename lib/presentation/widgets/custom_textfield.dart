import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_bottomsheet.dart';
import 'package:flutter/material.dart';

class BgaCustomTextFieldAndBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> itemList;
  final Widget? textField;
  final Widget? button;

  const BgaCustomTextFieldAndBottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.itemList,
    this.textField,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: BgaTextStyle.titleBoldText
        ),
        SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight(),),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder10,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Show the bottom sheet
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BgaCustomBottomSheet(
                          textField: textField,
                          button: button,
                          children: itemList.map((item) {
                            return ListTile(
                              title: Text(item),
                              onTap: () {
                                // Handle item selection
                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: BgaPaddingSize.getBgaPaddingSymmHorizontal10(),
                    child: textField ?? Text(description),
                  ),
                ),
              ),
              Icon(icon),
            ],
          ),
        ),
      ],
    );
  }
}
