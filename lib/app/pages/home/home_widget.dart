//import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_appevents/flutter_facebook_appevents.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/todo_page.dart';
import 'package:new_todo_trianons/app/pages/onboard_page/onboard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics =
        Provider.of<FirebaseAnalytics>(context, listen: false);

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
              (_) => Hive.openBox('onboarding'),
            )
            .then(
              (_) => analytics.logAppOpen(),
            )
            .then(
              (_) => FacebookAppEvents.logEvent('AppOpen', {}),
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
            print('boolean: ${Hive.box('onboarding').get('bool')}');

            if (Hive.box('onboarding').get('bool') != false) {
              return Scaffold(
                body: Center(
                  child: OnboardScreen(false),
                ),
              );
            } else
              return MyTodoPage();
          }

          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
