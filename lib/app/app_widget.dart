import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/shared/repository/firebase_provider.dart';
import 'package:provider/provider.dart';

import 'pages/hints/dicas_provider.dart';
import 'pages/ToDoS/bloc/drop_icons_provider.dart';
import 'pages/home/home_widget.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Analytics>(
          create: (_) => Analytics(),
        ),
        Provider<Index>(
          create: (_) => Index(),
        ),
        ChangeNotifierProvider<DicasState>.value(value: DicasState()),
        ChangeNotifierProvider<DropdownLinks>.value(value: DropdownLinks()),
      ],
      child: HomeScreen(),
    );
  }
}
