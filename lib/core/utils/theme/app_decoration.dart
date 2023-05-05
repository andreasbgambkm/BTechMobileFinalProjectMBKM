
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
  static BorderRadius customBorderTL102 = BorderRadius.only(
    topLeft: Radius.circular(2),
    bottomLeft: Radius.circular(10
    ),
    bottomRight: Radius.circular(10),
  );

  static BorderRadius customBorderTL101 = BorderRadius.only(
    topLeft: Radius.circular(10,
    ),
    topRight: Radius.circular(

        10,

    ),
    bottomRight: Radius.circular(
        10,
    ),
  );

  static BorderRadius roundedBorder5 = BorderRadius.circular(5
  );

  static BorderRadius roundedBorder15 = BorderRadius.circular(15);

  static BorderRadius roundedBorder10 = BorderRadius.circular(10);

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

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;

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

  static TextStyle homeTitleBoldText = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins',
    color: BgaColor.bgaBlackTitleBold,
  );
  static TextStyle homeSubtitleText = TextStyle(
    fontSize: 12.0,
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
  static const double bgaRowPaddingPadding= 11.0;


  static EdgeInsets getPaddingBody() {
    return const EdgeInsets.only(top: bgaTopPadding, left:bgaLeftPadding ,right: bgaRightPadding, bottom: bgaBottomPadding );
  }
  static EdgeInsets getPaddingGpsCard() {
    return const EdgeInsets.only(top: bgaTopGpsCardPadding);
  }
  static EdgeInsets getPaddingRkhCard() {
    return const EdgeInsets.only(top: bgaTopCardRkhPadding, bottom: bgaBottomPadding);
  }
}

