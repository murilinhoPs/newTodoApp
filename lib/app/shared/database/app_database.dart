import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:new_todo_trianons/app/shared/model/todo_model.dart';

class AppDatabase {
  // Singleton da classe
  static final AppDatabase _singleton = AppDatabase._();

  // Get the instance
  static AppDatabase get instance => _singleton;

  AppDatabase._(); //private instance

  // Iniciar o db
  Future<void> get database async {
    final appDirectory = await getApplicationDocumentsDirectory();

    final dbPath = join(appDirectory.path + '/' + 'app.db');

    print('Path of New Dir: ' + dbPath);

    final db = Hive.init(dbPath);

    // qual hive adaptar deseja registrar no app
    Hive.registerAdapter(TodoModelAdapter());

    print('abri o db');
    return db;
  }
}
