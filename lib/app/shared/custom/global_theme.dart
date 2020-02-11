import 'package:flutter/material.dart';

import 'Colors.dart';

class MyTheme {
  static final ThemeData globalTheme = ThemeData(
      fontFamily: 'Nunito',
      iconTheme: IconThemeData(
        color: Cor().appBarGradientCima,
      ),
      accentIconTheme: IconThemeData(
        color: Cor().appBarGradientCima,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        brightness: Brightness.light,
        color: Colors.transparent,
        //actionsIconTheme: IconThemeData(color: Colors.white, size: 35),
        textTheme: TextTheme(
          headline6: TextStyle(color: Cor().customColor, fontSize: 30),
          bodyText1: TextStyle(color: Cor().customColor, fontSize: 22),
        ),
      ),
      dialogTheme: DialogTheme(
        contentTextStyle: TextStyle(color: Cor().customColorBody, fontSize: 16),
      ),
      brightness: Brightness.light,
      primaryColor: Colors.white,
      dividerColor: Colors.grey[400],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Cor().appBarGradientCima,
        elevation: 3.0,
      ),
      cursorColor: Cor().customColor, //Colors.purple[600],
      accentColor: Cor().customColorBody, //Colors.purple[600],
      textTheme: TextTheme(
        caption: TextStyle(
            decorationColor: Cor().customColor,
            color: Cor().customColor,
            fontSize: 20,
            fontFamily: 'Nunito'),
        bodyText1: TextStyle(
            fontFamily: 'Nunito', fontSize: 18, color: Cor().customColor),
        subtitle1: TextStyle(
            decorationColor: Cor().customColor,
            color: Cor().customColor,
            fontSize: 20,
            fontFamily: 'Nunito'),
        headline1: TextStyle(
            decorationColor: Cor().customColor,
            color: Cor().customColor,
            fontSize: 22,
            fontFamily: 'Nunito'),
      ),
      cardTheme: CardTheme(
        elevation: 4.0,
      ));
}
