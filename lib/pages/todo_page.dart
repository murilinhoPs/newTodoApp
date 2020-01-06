import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_todo_trianons/model/todo_model.dart';
import 'package:toast/toast.dart';
import 'package:new_todo_trianons/custom/Colors.dart';

class MyTodoPage extends StatefulWidget {
  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  // Controle para os text fields para criar o Todo
  TextEditingController _taskNameController;
  TextEditingController _taskNoteController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New ToDo'),
      ),
      body: FutureBuilder(
          future: Hive.openBox('tasks'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else {
                return todoList(context);
              }
            } else
              return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTodoDialog();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget todoList(BuildContext context) {
    return Center(
      child: Text(
        'It will be a todo page',
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Future _openTodoDialog(){
    final _formKey = GlobalKey<FormState>();
    String taskName = '';
    String taskNote = '';

    void addTodo(TodoModel todo) {
      final tasksBox = Hive.box('tasks');
      tasksBox.add(todo);
      print("Task name: ${todo.name}, Notes: ${todo.notes}");
      print('Box: ${tasksBox.toString()}');
    }

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            contentPadding: EdgeInsets.only(left: 24, right: 24, bottom: 12.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Text(
              'Seu planejamento',
              style: TextStyle(fontFamily: ' Nunito'),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Task name
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        cursorColor: Cor().customColor,
                        controller: _taskNameController,
                        autofocus: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                            focusColor: Cor().customColor,
                            labelStyle: TextStyle(color: Cor().customColor),
                            labelText: 'tarefa',
                            hintText: 'sua tarefa'),
                        onChanged: (value) {
                          taskName = value;
                        },
                      ),
                    ),
                  ],
                ),
                // Task note
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        cursorColor: Cor().customColor,
                        maxLines: null,
                        enableInteractiveSelection: true,
                        controller: _taskNoteController,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Cor().customColor),
                            labelText: 'anotações',
                            hintText: 'Adicione anotações na sua tarefa'),
                        onChanged: (value) {
                          taskNote = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                // O texto muda de acordo com o todo, se vai criar um novo ou editar
                child: Text('Criar nova tarefa'),
                onPressed: () {
                  if (taskName.trim().length < 1) {
                    Toast.show('Nada escrito!', context,
                        duration: 4,
                        backgroundColor: Colors.grey[300],
                        textColor: Colors.black);
                  } else {
                    _formKey.currentState.save();
                    final newTodo = TodoModel(name: taskName, notes: taskNote);
                    addTodo(newTodo);
                    _formKey.currentState.reset();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
