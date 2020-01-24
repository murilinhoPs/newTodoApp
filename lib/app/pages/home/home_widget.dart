import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/todo_page.dart';
import 'package:new_todo_trianons/app/shared/custom/global_theme.dart';
import 'package:new_todo_trianons/app/shared/repository/firebase_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final Analytics analise = Provider.of<Analytics>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyTheme.globalTheme,
      navigatorObservers: <NavigatorObserver>[analise.observer],
      home: FutureBuilder(
          future: Hive.openBox(
            'tasks',
            compactionStrategy: (int total, int deleted) {
              return total > 1;
            },
          )
              .then(
                (_) => Hive.openBox('indices'),
              )
              .then(
                (_) => analise.analytics.logAppOpen(),
              ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              }
              return MyTodoPage();
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
    );
  }
}
