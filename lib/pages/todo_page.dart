import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_todo_trianons/bloc/dicas_provider.dart';
import 'package:new_todo_trianons/bloc/drop_icons_provider.dart';
import 'package:new_todo_trianons/bloc/open_links.dart';
import 'package:new_todo_trianons/database/crud_indices.dart';
import 'package:new_todo_trianons/model/todo_model.dart';
import 'package:new_todo_trianons/pages/tips_page.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:new_todo_trianons/custom/Colors.dart';

import '../custom/my_flutter_app_icons.dart';
import '../database/crud_database.dart';

class MyTodoPage extends StatefulWidget {
  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskNoteController = TextEditingController();

  final TodoCrud crudOperations = TodoCrud();
  final _crudIndices = TodoIndicesCrud();

  final tasksBox = Hive.box('tasks');

  final CardLinks todosIcons = CardLinks();

  int testIndex = 0;

  @override
  void initState() {
    //Hive.box('indices').clear();
    //tasksBox.clear();
    // _crudIndices.updateIndex(0);
    testIndex = _crudIndices.readIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
        valueListenable: Hive.box('tasks').listenable(),
        builder: (BuildContext context, Box tasksBox, Widget widget) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              flexibleSpace: Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/estrelas.png',
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Cor().appBarGradientCima,
                      Cor().appBarGradientBaixo[700]
                    ],
                  ),
                ),
              ),
              title: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: phoneH * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        alignment: Alignment.center,
                        scale: phoneW * 0.008,
                        filterQuality: FilterQuality.high,
                      )
                    ],
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size(phoneW * 0.3, phoneH * 0.03),
                child: Container(
                  height: 10,
                ),
              ),
            ),
            body: _beforeTodoList(context),
            floatingActionButton: SpeedDial(
              child: Icon(Icons.note_add),
              //animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.create),
                    label: 'Criar novo',
                    onTap: () => _openTodoDialog(null)),
                SpeedDialChild(
                    child: Icon(Icons.add),
                    elevation: 0.0,
                    onTap: () {
                      Toast.show('Não interativo...', context,
                          duration: 2,
                          backgroundColor: Colors.grey[300],
                          textColor: Colors.black);
                    },
                    //label: 'Adicionar novo',
                    backgroundColor: Colors.grey[300]),
              ],
            ),
          );
        });
  }

  Widget _beforeTodoList(BuildContext context) {
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
              style: TextStyle(color: Colors.grey[700]),
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
                        if (tasksBox.length <= 0) _crudIndices.updateIndex(0);

                        print('teste: $testIndex');
                        print('saveIndex: ${_crudIndices.readIndex()}');
                        return _todoList(todo);
                      })
                  : Center(child: Text('Escreva sua primeira tarefa'))),
        ],
      ),
    );
  }

  Widget _todoList(TodoModel todo) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    final DicasState dicasProvider =
        Provider.of<DicasState>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(phoneW * .07))),
      margin: EdgeInsets.all(phoneW * .025),
      child: Column(
        children: <Widget>[
          _todoListTile(todo),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: phoneW * 0.14,
                child: RaisedButton(
                  color: Colors.grey[200],
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Icon(
                    MyFlutterIcons.lamp,
                    color: Colors.yellow[900],
                  ),
                  onPressed: () {
                    dicasProvider.dicas = todo.icon;

                    if (dicasProvider.dicas != 'Lembrete') {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Dicas(),
                        ),
                      );
                    } else {
                      return Toast.show('Nada para mostrar', context,
                          duration: 2,
                          backgroundColor: Colors.grey[300],
                          textColor: Colors.black);
                    }
                  },
                ),
              ),
              Container(
                width: phoneW * 0.17,
                height: phoneH * 0.05,
                child: RaisedButton(
                  color: Colors.grey[200],
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Icon(
                    todosIcons.renderIcon(todo.icon),
                    color: Cor().customColor,
                    size: phoneW * .062,
                  ),
                  onPressed: () {
                    todosIcons.platformOpenUrl(context, todo);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: phoneH * .015),
        ],
      ),
    );
  }

  Widget _todoListTile(TodoModel todo) {
    final phoneW = MediaQuery.of(context).size.width;

    return ListTile(
      title: todo.isDone
          ? Center(
              child: Text(
                todo.name,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Cor().customColorBody,
                    color: Colors.grey[500],
                    fontSize: phoneW * .05),
              ),
            )
          : Center(
              child: Text(
                todo.name,
                style: TextStyle(
                    color: Cor().customColorBody, fontSize: phoneW * .05),
              ),
            ),
      subtitle: todo.isDone
          ? Center(
              child: Text(
                todo.notes,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Cor().customColorBody,
                    color: Colors.grey[500],
                    fontSize: phoneW * .045),
              ),
            )
          : Center(
              child: Text(
                todo.notes,
                style: TextStyle(
                    color: Cor().customColorBody.shade700,
                    fontSize: phoneW * .045),
              ),
            ),
      leading: IconButton(
        icon: todo.isDone
            ? Icon(Icons.check_circle_outline, color: Cor().customColorBody)
            : Icon(Icons.radio_button_unchecked, color: Cor().customColorBody),
        onPressed: () {
          // BLOC
          crudOperations.updateTodo(
              todo.index,
              TodoModel(
                  index: todo.index,
                  name: todo.name,
                  notes: todo.notes,
                  isDone: !todo.isDone,
                  icon: todo.icon));
          // BLOC
        },
      ),
      trailing: IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            testIndex--;
            _crudIndices.updateIndex(testIndex);
            // BLOC
            crudOperations.deleteTodo(todo.index);
            // BLOC
          }),
      onTap: () {
        _openTodoDialog(todo);
      },
    );
  }

  Future _openTodoDialog(TodoModel todo) {
    final _formKey = GlobalKey<FormState>();
    String taskName = '';
    String taskNote = '';
    final DropdownLinks dropdownState =
        Provider.of<DropdownLinks>(context, listen: false);

    if (todo != null) {
      taskName = todo.name;
      taskNote = todo.notes;
      dropdownState.atualizarIcon(todo.icon); // Provider resolve isso

      _taskNameController.text = todo.name;
      _taskNoteController.text = todo.notes;
    } else {
      taskName = '';
      taskNote = '';
      dropdownState.atualizarIcon('Lembrete');
      _taskNoteController.clear();
      _taskNameController.clear();
    }

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Consumer<DropdownLinks>(builder: (context, provider, widget) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 12.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              title: Text(
                todo == null ? 'Crie sua tarefa' : 'Edite sua tarefa',
                style: TextStyle(fontFamily: ' Nunito'),
              ),
              content: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                //addRepaintBoundaries: true,
                //shrinkWrap: true,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InputDecorator(
                        decoration: InputDecoration(labelText: 'Redes Sociais'),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            items: dropdownState.iconNames.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                            value: dropdownState.selectionIcon,
                            onChanged: (value) {
                              dropdownState.atualizarIcon(value);
                            },
                            isExpanded: true,
                            iconSize: 24.0,
                          ),
                        ),
                      ),
                      // Task name
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              cursorColor: Cor().customColor,
                              controller: _taskNameController,
                              autofocus: true,
                              enableInteractiveSelection: true,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                  focusColor: Cor().customColor,
                                  labelStyle:
                                      TextStyle(color: Cor().customColor),
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
                                  labelStyle:
                                      TextStyle(color: Cor().customColor),
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
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Cor().customColor,
                  // O texto muda de acordo com o todo, se vai criar um novo ou editar
                  child: todo == null
                      ? Text('Criar nova tarefa')
                      : Text('Editar tarefa'),
                  onPressed: () {
                    if (taskName.trim().length < 1) {
                      Toast.show('Nada escrito!', context,
                          duration: 2,
                          backgroundColor: Colors.grey[300],
                          textColor: Colors.black);
                    }
                    if (todo == null) {
                      _formKey.currentState.save();
                      // BLOC
                      final newTodo = TodoModel(
                          name: taskName,
                          notes: taskNote,
                          icon: dropdownState.selectionIcon,
                          index: testIndex++);
                      crudOperations.createTodo(newTodo);
                      _crudIndices.updateIndex(testIndex);
                      // BLOC
                      _formKey.currentState.reset();
                    } else {
                      _formKey.currentState.save();
                      // BLOC
                      final newTodo = TodoModel(
                          name: taskName,
                          notes: taskNote,
                          icon: dropdownState.selectionIcon,
                          index: todo.index);

                      crudOperations.updateTodo(todo.index, newTodo);
                      _crudIndices.updateIndex(testIndex);
                      // BLOC
                      _formKey.currentState.reset();
                    }
                    Navigator.of(context)
                        .pop(dropdownState.atualizarIcon('Lembrete'));
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    Hive.box('tasks').compact();
    Hive.box('tasks').close();
    Hive.box('indices').close();
    super.dispose();
  }
}
