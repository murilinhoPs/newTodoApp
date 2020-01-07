import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/custom/global_theme.dart';
import 'package:new_todo_trianons/database/app_database.dart';
import 'package:new_todo_trianons/pages/todo_page.dart';
import 'package:provider/provider.dart';

import 'bloc/dicas_provider.dart';
import 'bloc/drop_icons_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;
  await Hive.openBox('indices');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DicasState>.value(value: DicasState()),
        ChangeNotifierProvider<DropdownLinks>.value(value: DropdownLinks()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: MyTheme.globalTheme,
        home: FutureBuilder(
            future: Hive.openBox(
              'tasks',
              compactionStrategy: (int total, int deleted) {
                return deleted > 10;
              },
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return MyTodoPage();
              }
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }),
      ),
    );
  }
}
