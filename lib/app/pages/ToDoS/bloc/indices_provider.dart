import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/app/shared/database/crud_database.dart';
import 'package:new_todo_trianons/app/shared/database/crud_indices.dart';
import 'package:new_todo_trianons/app/shared/model/todo_model.dart';
import 'package:provider/provider.dart';

class Index {
  int _testIndex = 0;

  int get testIndex => _testIndex;

  set testIndex(int value) => _testIndex = value;
}

class IndexChanges {
  final TodoCrud crudOperations = TodoCrud();
  final TodoIndicesCrud _crudIndices = TodoIndicesCrud();

  // verifica o index do último todo armazenado, se não tiver nada quer dizer que não tem nenhum todo então seu valor é 0
  Future initialize(BuildContext context) async {
    final Index testIndex = Provider.of<Index>(context,
        listen: false); // o provider do valor para não mexer diretamente no db

    if (await _crudIndices.readIndex() == null) {
      testIndex.testIndex = 0;
      await _crudIndices.updateIndex(0);
      // print(_crudIndices.readIndex());
      // print(testIndex);
    }
    // Pega o valor guardado no indices
    testIndex.testIndex = _crudIndices.readIndex();
  }

  // Verifica o index do todo e muda ele de acordo com a quantidade e posições de todo's na lista
  Future verifyIndices(
      int index, TodoModel newTodo, BuildContext context) async {
    final Index testIndex = Provider.of<Index>(context,
        listen: false); // o provider do valor para não mexer diretamente no db

    // quando não tiver nada no Hive.box('tasksbox') atualiza o valor para 0, no db e no provider
    if (Hive.box('tasks').length <= 0) {
      await _crudIndices.updateIndex(0);
      testIndex.testIndex = _crudIndices.readIndex();
      return;
    } else {
      // Se tiver todo's no Hive.box('tasksbox') e o seu index for diferente do último todo(o mais novo),
      // atualiza o index do todo naquela posição do array
      if (index != newTodo.index) {
        crudOperations.updateTodo(
          index,
          TodoModel(
              // mantém os valores do todo e só altera o index
              name: newTodo.name,
              notes: newTodo.notes,
              index: index,
              isDone: newTodo.isDone,
              icon: newTodo.icon),
        );
      }
    }
  }
}
