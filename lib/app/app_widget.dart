import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:provider/provider.dart';

import 'pages/hints/dicas_provider.dart';
import 'pages/ToDoS/bloc/drop_icons_provider.dart';
import 'pages/home/home_widget.dart';
import 'shared/custom/global_theme.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Index>(
          create: (_) => Index(),
        ),
        ChangeNotifierProvider<DicasState>.value(value: DicasState()),
        ChangeNotifierProvider<DropdownLinks>.value(value: DropdownLinks()),
        Provider<FirebaseAnalytics>.value(value: analytics),
        Provider<FirebaseAnalyticsObserver>.value(value: observer),
      ],
      child: MaterialApp(
        //darkTheme: MyTheme.globalTheme,
        debugShowCheckedModeBanner: false,
        title: 'Checklist Trianons',
        theme: MyTheme.globalTheme,
        navigatorObservers: <NavigatorObserver>[observer],
        home: HomeScreen(),
      ),
    );
  }
}
