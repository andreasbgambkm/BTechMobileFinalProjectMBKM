import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/material.dart';

class BgaCustomBottomSheet extends StatelessWidget {
  final List<Widget> children;
  final Widget? textField;
  final Widget? button;
  final Widget? searchBar;

  const BgaCustomBottomSheet({
    Key? key,
    required this.children,
    this.textField,
    this.button,
    this.searchBar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          if (textField != null) textField!,
          Expanded(
            child: ListView.builder(
              itemCount: children.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      if (textField != null && searchBar != null) textField!,
                      Expanded(
                        child: ListView.separated(
                          itemCount: children.length,
                          separatorBuilder: (BuildContext context, int index) => Divider(
                            color: BgaColor.bgaSearchBarColor, // Warna garis pembatas
                            thickness:1, // Lebar garis pembatas
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusStyle.customBorderBL10, // Radius circular
                              ),
                              child: children[index],
                            );
                          },
                        ),
                      ),
                      if (button != null) button!,
                    ],
                  ),
                );

              },
            ),
          ),
          if (button != null) button!,
        ],
      ),
    );

  }
}
