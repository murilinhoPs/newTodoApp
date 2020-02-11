//import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_appevents/flutter_facebook_appevents.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/body.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/dialogs.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/my_drawer.dart';
import 'package:provider/provider.dart';

import 'components/my_app_bar.dart';

class MyTodoPage extends StatefulWidget {
  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final tasksBox = Hive.box('tasks');

  final Dialogs _dialogs = Dialogs();

  final IndexChanges _listenIndex = IndexChanges();

  //final fbEvent = FacebookAnalytics();

  void _sendScreenInfo(BuildContext context) {
    final FirebaseAnalyticsObserver observer =
        Provider.of<FirebaseAnalyticsObserver>(context, listen: false);

    observer.analytics.setCurrentScreen(
        screenName: 'MyTodoPage', screenClassOverride: 'MyTodoPage');

    FacebookAppEvents.logEvent('MyTodoPageOpen', {});
  }

  @override
  void initState() {
    _listenIndex.initialize(context);
    _sendScreenInfo(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics =
        Provider.of<FirebaseAnalytics>(context, listen: false);

    return Scaffold(
      appBar: MyAppBar().build(context),
      drawer: MyDrawer(),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.note_add),
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
              child: Icon(Icons.create),
              label: 'Criar novo',
              labelStyle: Theme.of(context).textTheme.bodyText1,
              onTap: () async {
                _dialogs.openTodoDialog(null, context);
                await analytics.logEvent(
                  name: 'Criar_custom',
                  parameters: <String, dynamic>{
                    'criar': 'criou seu todo customizavel'
                  },
                );
              }),
          SpeedDialChild(
            child: Icon(Icons.add),
            elevation: 0.0,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText1, //MyTheme.globalTheme.textTheme.bodyText1,
            onTap: () async {
              _dialogs.openTemplateDialog(null, context);
              await analytics.logEvent(
                name: 'create_template',
                parameters: <String, dynamic>{
                  'string': 'criou seu todo template'
                },
              );
            },
            label: 'Criar template',
          ),
        ],
      ),
      body:
          // Consumer do Hive.box(o widget que vai rebuildar quando algum valor no Hive.box('tasks') mudar => ouvir)
          ValueListenableBuilder(
        valueListenable: Hive.box('tasks').listenable(),
        builder: (BuildContext context, Box tasksBox, Widget widget) =>
            BodyApp(),
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('tasks').compact();
    Hive.box('tasks').close();
    Hive.box('indices').close();
    super.dispose();
  }
}
