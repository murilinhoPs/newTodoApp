import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/todo_list.dart';
import 'package:new_todo_trianons/app/shared/repository/crud_database.dart';

class BodyApp extends StatelessWidget {
  BodyApp();

  final tasksBox = Hive.box('tasks');

  final TodoCrud crudOperations = TodoCrud();
  final IndexChanges _listenIndex = IndexChanges();

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    final percent = tasksBox.length > 0
        ? ((crudOperations.filterTodo().length / tasksBox.length) * 100)
        : 0;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: phoneH * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(left: phoneW / 20.0),
            padding: EdgeInsets.all(10),
            child: Text(
              "${crudOperations.filterTodo().length} Tarefas prontas",
              style: TextStyle(
                  color: Colors.grey[700], fontFamily: 'Nunito', fontSize: 20),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: phoneW * 0.03,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  height: phoneH * .002,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    value: (percent / 100),
                  ),
                ),
              ),
              SizedBox(
                width: phoneW * .01,
              ),
              //Text('${percent.floor()}%',style: TextStyle(color: Colors.grey[700]))
            ],
          ),
          Expanded(
            child: tasksBox.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasksBox.length,
                    itemBuilder: (context, index) {
                      final todo = crudOperations.readTodo(index);

                      _listenIndex.verifyIndices(index, todo, context);

                      // print('builderLenght: ${tasksBox.length}');
                      // print('saveIndex: ${_crudIndices.readIndex()}');
                      return ToDoList(todo: todo);
                    })
                : Center(
                    child: Text(
                      'Escreva sua primeira tarefa',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
