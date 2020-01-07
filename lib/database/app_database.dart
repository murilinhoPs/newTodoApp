import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:new_todo_trianons/model/todo_model.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  AppDatabase._();

  Future<void> get database async {
    final appDirectory = await getApplicationDocumentsDirectory();

    final dbPath = join(appDirectory.path + 'app.db');

    final db = Hive.init(dbPath);

    Hive.registerAdapter(TodoModelAdapter());

    print('abri o db');
    return db;
  }
}
