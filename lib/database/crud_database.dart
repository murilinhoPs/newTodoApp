import 'package:hive/hive.dart';
import 'package:new_todo_trianons/model/todo_model.dart';

class TodoCrud {
  final _tasksBox = Hive.box('tasks');

  void createTodo(TodoModel todo) {
    _tasksBox.add(todo);
    //print("Task name: ${todo.name}, Notes: ${todo.notes}");
  }

  TodoModel readTodo(int index) {
    return _tasksBox.getAt(index);
  }

  void updateTodo(int index, dynamic todo) {
    _tasksBox.putAt(index, todo);
  }

  void deleteTodo(int index) {
    _tasksBox.deleteAt(index);
  }
}
