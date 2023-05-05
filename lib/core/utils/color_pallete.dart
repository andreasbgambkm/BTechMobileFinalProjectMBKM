import 'dart:ui';
import 'package:flutter/material.dart';

class BgaColor {
  static Color bgaOrange = fromHex('#FFA629');

  static Color bgaBodyColor = fromHex('#FFFFFF');

  static Color bgaBlackTitleBold = fromHex('#4F4F4F');

  static Color bgaBlackSubTitleBold = fromHex('#00000');

  static Color bgaOrangeBottomNavigation = fromHex('#FFF0DB');

  static Color bgaGray400 = fromHex('#b3b3b3');

  static Color bgaBlueGray400 = fromHex('#888888');

  static Color bgaGray800 = fromHex('#4e4e4e');

  static Color bgaLightGreen100 = fromHex('#e2ffd5');

  static Color bgaLightGreenList = fromHex('#E3FFD6');

  static Color bgaOrangeCounterOrang = fromHex('#ffa629');

  static Color bgaLightRedList = fromHex('#FFE9E4');

  static Color bgaGray200 = fromHex('#ebe8e8');

  static Color bgaGray300 = fromHex('#e0e0e0');

  static Color bgaGray50 = fromHex('#f8f8f8');

  static Color bgaBlack90001 = fromHex('#050505');

  static Color bgaGreenA700 = fromHex('#1dcd2e');

  static Color bgaOrange50 = fromHex('#ffefda');

  static Color bgaBlack900 = fromHex('#000000');

  static Color bgaBlack90019 = fromHex('#19000000');

  static Color bgaWhiteA700 = fromHex('#ffffff');

  static Color bgaSearchBarColor = fromHex('#F8F8F8');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
