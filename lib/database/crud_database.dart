import 'package:hive/hive.dart';
import 'package:new_todo_trianons/model/todo_model.dart';

class TodoCrud {
  final box = Hive.box('tasks');

  void readTodo() {}

  void createTodo(TodoModel value) {
    box.add(value);
  }

  void updateTodo() {}

  void deleteTodo() {}
}
