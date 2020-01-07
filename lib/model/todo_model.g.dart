// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      name: fields[0] as String,
      notes: fields[1] as String,
      icon: fields[5] as String,
      isDone: fields[3] as bool,
      index: fields[4] as int,
    )..oldIcon = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.notes)
      ..writeByte(2)
      ..write(obj.oldIcon)
      ..writeByte(3)
      ..write(obj.isDone)
      ..writeByte(4)
      ..write(obj.index)
      ..writeByte(5)
      ..write(obj.icon);
  }
}
