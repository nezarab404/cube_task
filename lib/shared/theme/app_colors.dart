import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xff5b20cb);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
}

extension ConvertToMaterial on Color {
  toMaterialColor() {
    Map<int, Color> values = const {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    return MaterialColor(value, values);
  }
}
