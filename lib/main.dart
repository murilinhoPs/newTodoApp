import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_todo_trianons/database/app_database.dart';
import 'package:new_todo_trianons/pages/todo_page.dart';

import 'custom/Colors.dart';
import 'model/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData globalTheme = ThemeData(
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: globalTheme,
      home: ValueListenableBuilder(
          valueListenable: Hive.box('tasks').listenable(),
          builder:
              (BuildContext context, Box tasksBox, Widget widget) {
            return MyTodoPage();
            //return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
    );
  }
}
