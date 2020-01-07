import 'package:flutter/material.dart';

import 'Colors.dart';

class MyTheme {
  static final ThemeData globalTheme = ThemeData(
      fontFamily: 'Nunito',
      primaryColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Cor().appBarGradientCima, elevation: 7.0),
      iconTheme: IconThemeData(
          color: Cor()
              .customColor[600]), //IconThemeData(color: Colors.purple[600]),
      cursorColor: Cor().customColor, //Colors.purple[600],
      accentColor: Cor().customColorBody, //Colors.purple[600],
      textTheme: TextTheme(
        body1: TextStyle(
            fontFamily: 'Nunito', fontSize: 16, color: Cor().customColor),
        subtitle: TextStyle(
            decorationColor: Cor().customColor,
            color: Cor().customColor,
            fontSize: 18,
            fontFamily: 'Nunito'),
        title: TextStyle(
            decorationColor: Cor().customColor,
            color: Cor().customColor,
            fontSize: 22,
            fontFamily: 'Nunito'),
      ),
      cardTheme: CardTheme(
        elevation: 2.0,
      ));
}
