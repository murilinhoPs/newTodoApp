import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel{

  @HiveField(0)
  String name;
  @HiveField(1)
  String notes;
  @HiveField(2)
  int oldIcon;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  int index;
  @HiveField(5)
  String icon;

  TodoModel({this.name, this.notes, this.icon = 'Lembrete', this.isDone = false, this.index});


}