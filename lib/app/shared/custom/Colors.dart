import 'package:flutter/material.dart';

class Cor {
  static Map<int, Color> darkPurple = {
    50: Color.fromRGBO(96, 77, 146, .1),
    100: Color.fromRGBO(96, 77, 146, .2),
    200: Color.fromRGBO(96, 77, 146, .3),
    300: Color.fromRGBO(96, 77, 146, .4),
    400: Color.fromRGBO(96, 77, 146, .5),
    500: Color.fromRGBO(96, 77, 146, .6),
    600: Color.fromRGBO(96, 77, 146, .7),
    700: Color.fromRGBO(96, 77, 146, .8),
    800: Color.fromRGBO(96, 77, 146, .9),
    900: Color.fromRGBO(96, 77, 146, 1),
  };

  static Map<int, Color> lighterPurple = {
    50: Color.fromRGBO(90, 15, 105, .1),
    100: Color.fromRGBO(90, 15, 105, .2),
    200: Color.fromRGBO(90, 15, 105, .3),
    300: Color.fromRGBO(90, 15, 105, .4),
    400: Color.fromRGBO(90, 15, 105, .5),
    500: Color.fromRGBO(90, 15, 105, .6),
    600: Color.fromRGBO(90, 15, 105, .7),
    700: Color.fromRGBO(90, 15, 105, .8),
    800: Color.fromRGBO(90, 15, 105, .9),
    900: Color.fromRGBO(90, 15, 105, 1),
  };

  static Map<int, Color> lightPink = {
    50: Color.fromRGBO(236, 210, 250, .1),
    100: Color.fromRGBO(236, 210, 250, .2),
    200: Color.fromRGBO(236, 210, 250, .3),
    300: Color.fromRGBO(236, 210, 250, .4),
    400: Color.fromRGBO(236, 210, 250, .5),
    500: Color.fromRGBO(236, 210, 250, .6),
    600: Color.fromRGBO(236, 210, 250, .7),
    700: Color.fromRGBO(236, 210, 250, .8),
    800: Color.fromRGBO(236, 210, 250, .9),
    900: Color.fromRGBO(236, 210, 250, .98),
  };

  static Map<int, Color> gradientLightBlue = {
    50: Color.fromRGBO(128, 205, 232, .1),
    100: Color.fromRGBO(128, 205, 232, .2),
    200: Color.fromRGBO(128, 205, 232, .3),
    300: Color.fromRGBO(128, 205, 232, .4),
    400: Color.fromRGBO(128, 205, 232, .5),
    500: Color.fromRGBO(128, 205, 232, .6),
    600: Color.fromRGBO(128, 205, 232, .7),
    700: Color.fromRGBO(128, 205, 232, .8),
    800: Color.fromRGBO(128, 205, 232, .9),
    900: Color.fromRGBO(128, 205, 232, 1),
  };

  static Map<int, Color> gradientLightPurple = {
    50: Color.fromRGBO(169, 107, 202, .1),
    100: Color.fromRGBO(169, 107, 202, .2),
    200: Color.fromRGBO(169, 107, 202, .3),
    300: Color.fromRGBO(169, 107, 202, .4),
    400: Color.fromRGBO(169, 107, 202, .5),
    500: Color.fromRGBO(169, 107, 202, .6),
    600: Color.fromRGBO(169, 107, 202, .7),
    700: Color.fromRGBO(169, 107, 202, .8),
    800: Color.fromRGBO(169, 107, 202, .9),
    900: Color.fromRGBO(169, 107, 202, 1),
  };

  MaterialColor customColor = MaterialColor(0xFF604D92, darkPurple);
  MaterialColor customColorBody = MaterialColor(0xFF5A0F64, lighterPurple);
  MaterialColor customColorAppBar = MaterialColor(0xFFECD2FA, lightPink);
  MaterialColor appBarGradientCima = MaterialColor(0xFF8070E0, gradientLightBlue);
  MaterialColor appBarGradientBaixo = MaterialColor(0xFFA96BCA, gradientLightPurple);
}
