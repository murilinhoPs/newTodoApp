import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_todo_trianons/app/shared/database/app_database.dart';

import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;
  //await Hive.openBox('indices');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(AppWidget()));
}
