import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_bottomsheet.dart';
import 'package:BTechApp_Final_Project/presentation/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
class BgaCustomTextFieldAndBottomSheet extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> itemList;
  final Widget? textField;
  Widget? searchBarField;
  final Widget? button;

  BgaCustomTextFieldAndBottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.itemList,
    this.textField,
    this.button,
    this.searchBarField,
  }) : super(key: key);

  @override
  _BgaCustomTextFieldAndBottomSheetState createState() => _BgaCustomTextFieldAndBottomSheetState();
}

class _BgaCustomTextFieldAndBottomSheetState extends State<BgaCustomTextFieldAndBottomSheet> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: BgaTextStyle.titleBoldText,
        ),
        SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
        Container(
          height: 55,
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
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: BgaCustomBottomSheet(
                            searchbarField: Padding(
                              padding: const EdgeInsets.only(
                                left: BgaPaddingSize.bgaLeftGpsCardPadding,
                                right: BgaPaddingSize.bgaRightGpsCardPadding,
                                top: BgaPaddingSize.bgaTopPadding,
                              ),
                              child: BgaCustomSearchBar(onChanged: (String) {}),
                            ),
                            button: widget.button,
                            children: widget.itemList.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () {
                                  // Handle item selection
                                  setState(() {
                                    selectedValue = item;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: BgaPaddingSize.getBgaPaddingSymmHorizontal10(),
                    child: Padding(
                      padding: BgaPaddingSize.getPaddingLeftRight20(),
                      child: widget.textField ?? Text(selectedValue.isEmpty ? widget.description : selectedValue, style: BgaTextStyle.searchBarText),
                    ),
                  ),
                ),
              ),

              Icon(widget.icon, color: BgaColor.bgaBlack900),
            ],
          ),
        ),
        SizedBox(height: BgaSizedboxSize.getSizedBoxMaxHeight()),
      ],
    );
  }
}
