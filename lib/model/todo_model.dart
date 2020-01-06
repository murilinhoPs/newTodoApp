import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_generator/hive_generator.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel{

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String notes;
  @HiveField(2)
  final int icon;
  @HiveField(3)
  final bool isDone;

  TodoModel({@required this.name, this.notes, this.icon, this.isDone = false});


}