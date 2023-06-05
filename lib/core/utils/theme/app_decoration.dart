
import 'package:flutter/material.dart';
import 'package:BTechApp_Final_Project/core/utils/color_pallete.dart';

class AppDecoration {
  static BoxDecoration get outlineBlack900191 => BoxDecoration(
    color: BgaColor.bgaWhiteA700,
    boxShadow: [
      BoxShadow(
        color: BgaColor.bgaBlack90019,
        spreadRadius: 2.0,
        blurRadius: 2.0,
        offset: Offset(
          0,
          -1,
        ),
      ),
    ],
  );
  static BoxDecoration get outlineGray300 => BoxDecoration(
    color: BgaColor.bgaWhiteA700,
    border: Border.all(
      color: BgaColor.bgaGray300,
      width: 1.0,
    ),
  );
  static BoxDecoration get txtFillOrange400 => BoxDecoration(
    color: BgaColor.bgaOrange,
  );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
    color: BgaColor.bgaWhiteA700,
  );
  static BoxDecoration get outlineBlack90019 => BoxDecoration(
    color: BgaColor.bgaWhiteA700,
    boxShadow: [
      BoxShadow(
        color: BgaColor.bgaBlack90019,
        spreadRadius: 2.0,
        blurRadius: 2.0,
        offset: Offset(
          0,
          2,
        ),
      ),
    ],
  );
  static BoxDecoration get fillOrange50 => BoxDecoration(
    color: BgaColor.bgaOrange50,
  );
}

class BorderRadiusStyle {
  static BorderRadius customBorderTL102 = const BorderRadius.only(
    topLeft: Radius.circular(2),
    bottomLeft: Radius.circular(10
    ),
    bottomRight: Radius.circular(10),
  );

  static BorderRadius customBorderTL101 = const BorderRadius.only(
    topLeft: Radius.circular(10,
    ),
    topRight: Radius.circular(

        10,

    ),
    bottomRight: Radius.circular(
        10,
    ),
  );

  static BorderRadius customTopBorder25 = const BorderRadius.only(
    topLeft: Radius.circular(25,
    ),
    topRight: Radius.circular(

    25,

    ),
  );

  static BorderRadius customTopBorder50 = const BorderRadius.only(
    topLeft: Radius.circular(50,
    ),
    topRight: Radius.circular(

      50,

    ),
  );


  static double borderRadiusQR10 = 10.0;
  static double borderLengthQR = 30.0;
  static double borderWidthQR = 10.0;


  static BorderRadius roundedBorder5 = BorderRadius.circular(5
  );
  static BorderRadius bgaAvatarRadius45 = BorderRadius.circular(45);
  static BorderRadius bgaroundedBorder15 = BorderRadius.circular(15);

  static BorderRadius roundedBorder10 = BorderRadius.circular(10.0);

  static BorderRadius customBorderTL10 = BorderRadius.only(
    topLeft: Radius.circular(10),
    topRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  );

  static BorderRadius txtRoundedBorder5 = BorderRadius.circular(5);

  static BorderRadius customBorderBL10 = BorderRadius.only(
    topRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;


class BgaTextStyle {
  static TextStyle loginTitleBold = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlackTitleBold,
  );

  static TextStyle loginInputText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Open Sans',

    color: BgaColor.bgaGray200,
  );
  static TextStyle buttonBGATextPrimary = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: BgaColor.bgaWhiteA700,
  );

  static TextStyle buttonBGATextSecondary = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: BgaColor.bgaOrange,
  );

  static TextStyle titleBoldText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlackTitleBold,
  );

  static TextStyle titleNormalText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlackTitleBold,
  );

  static TextStyle subtitleText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlack900,
  );

  static TextStyle subtitleBoldText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlack900,
  );

  static TextStyle subtitleText2 = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlack900,
  );

  static TextStyle homeCounterCardText = TextStyle(
    fontSize: 35.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaOrange,
  );

  static TextStyle homeCounterPersonText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Poppins',
    color: BgaColor.bgaOrange,
  );

  static TextStyle searchBarText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Open Sans',
    color: BgaColor.bgaBlackTitleBold,
  );

  static TextStyle appBarText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaWhiteA700,

  );

  static TextStyle alertTitleBold = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaWhiteA700,
  );
}

class BgaPaddingSize {

  static const double bgaTopPadding = 18.0;
  static const double bgaLeftPadding = 20.0;
  static const double bgaTopCardRkhPadding = 11.0;
  static const double bgaRightPadding = 20.0;
  static const double bgaBottomPadding = 20.0;
  static const double bgaTopGpsCardPadding = 8.0;
  static const double bgaLeftGpsCardPadding = 20.0;
  static const double bgaRightGpsCardPadding = 20.0;
  static const double bgaBottomGpsCardPadding= 11.0;
  static const double bgaRowPadding= 11.0;
  static const double bgaNikPaddingTop = 18.0;
  static const double bgaNikPaddingBottom = 8.0;
  static const double bgaTopPaddingAvatarAlert = 45.0;


  static EdgeInsets getPaddingTopAlertMargin(){
    return const EdgeInsets.only(top: 60.0);
  }
  static EdgeInsets getPaddingBottomSheetAll(){
    return const EdgeInsets.all(16.0);
  }

  static EdgeInsets getPaddingAlertButton(){
    return const EdgeInsets.all(20.0);
  }

  static EdgeInsets getPaddingBody() {
    return const EdgeInsets.only(top: bgaTopPadding, left:bgaLeftPadding ,right: bgaRightPadding, bottom: bgaBottomPadding );
  }
  static EdgeInsets getPaddingGpsCard() {
    return const EdgeInsets.only(top: bgaTopGpsCardPadding);
  }
  static EdgeInsets getPaddingRkhCard() {
    return const EdgeInsets.only(top: bgaTopCardRkhPadding, bottom: bgaBottomPadding);
  }
  static EdgeInsets getPaddingRowCounterPekerja() {
    return const EdgeInsets.only(bottom:7.0);
  }
  static EdgeInsets getPaddingScanButton() {
    return const EdgeInsets.only(top: 21.0, bottom: 43);
  }
  static EdgeInsets getPaddingSearchBarDaftarPekerja() {
    return const EdgeInsets.only( bottom: 22);
  }
  static EdgeInsets getPaddingItemCard() {
    return const EdgeInsets.only( bottom: 15);
  }
  static EdgeInsets getPaddingNikInCheckIn(){
    return const EdgeInsets.only(top: bgaNikPaddingTop, bottom: bgaBottomPadding);
  }
  static EdgeInsets getBgaPaddingSymmetric20(){
   return const EdgeInsets.symmetric(vertical: 20.0);
  }
  static EdgeInsets getBgaPaddingSymmHorizontal13(){
    return const EdgeInsets.symmetric(vertical: 13.0);
  }
  static EdgeInsets getBgaPaddingSymmHorizontal10(){
    return const EdgeInsets.symmetric(vertical: 10.0);
  }

  static EdgeInsets getBgaPaddingNotesCheckOut(){
    return const EdgeInsets.symmetric(vertical: 40, horizontal: 16);
  }


  static EdgeInsets getBgaPaddingBackgroundColorCheckinTime(){
    return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  }
  static EdgeInsets getPaddingBottom8() {
    return const EdgeInsets.only( bottom: 8);
  }

  static EdgeInsets getPaddingLeftRight20() {
    return const EdgeInsets.only( right: 20, left: 20);
  }
}

class BgaIconSize{


  static double getIconUserWidth() {
    return 24.0;
  }

  static double getIconUserHeight() {
    return 24.0;
  }

}

class BgaSizedboxSize{
  static double getSizedBoxLowHeight(){
    return 5;
  }

  static double getSizedBoxMidHeight(){
    return 10;
  }

  static double getSizedBoxAlertHeight(){
    return 30;
  }

  static double getSizedBoxMaxHeight(){
    return 15;
  }
}
class BgaHomeConfig {
  static double getPaddingTopQuery(BuildContext context) {
    return MediaQuery.of(context).padding.top / 2.5;
  }
}
