import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/todo_page.dart';
import 'package:provider/provider.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics =
        Provider.of<FirebaseAnalytics>(context, listen: false);

    final fbEvent = FacebookAppEvents();

    return FutureBuilder(
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
              (_) => analytics.logAppOpen(),
            )
            .then((_) => fbEvent.logEvent(name: 'Abriu_App')),
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
        });
  }
}
