import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';
import 'package:BTechApp_Final_Project/core/utils/theme/app_decoration.dart';
import 'package:flutter/material.dart';

class BgaCustomBottomSheet extends StatelessWidget {
  final List<Widget> children;
  final Widget? searchbarField;
  final Widget? button;

  const BgaCustomBottomSheet({
    Key? key,
    required this.children,
    this.searchbarField,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: <Widget> [
            Expanded(
              child: ListView.builder(
                itemCount: children.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        if (searchbarField != null) searchbarField!,
                        Expanded(
                          child: ListView.separated(
                            itemCount: children.length,
                            separatorBuilder: (BuildContext context, int index) => Divider(
                              color: BgaColor.bgaSearchBarColor,
                              thickness: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusStyle.customBorderBL10,
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
      ),
    );
  }
}
