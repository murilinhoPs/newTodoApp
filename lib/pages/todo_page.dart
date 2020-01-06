import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_todo_trianons/model/todo_model.dart';
import 'package:toast/toast.dart';
import 'package:new_todo_trianons/custom/Colors.dart';

import '../custom/my_flutter_app_icons.dart';
import '../database/crud_database.dart';

class MyTodoPage extends StatefulWidget {
  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  // Controle para os text fields para criar o Todo
  TextEditingController _taskNameController;
  TextEditingController _taskNoteController;

  final TodoCrud crudOperations = TodoCrud();

  final tasksBox = Hive.box('tasks');

  @override
  initState() {
    _taskNoteController = TextEditingController();
    _taskNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 7.0,
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
            )),
      ),
      body: _beforeTodoList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //tasksBox.clear();
          _openTodoDialog(null);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _beforeTodoList(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    final valIsDone =
        tasksBox.values.where((todo) => todo.isDone == true).toList();

    final percent =
        tasksBox.length > 0 ? ((valIsDone.length / tasksBox.length) * 100) : 0;

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
              "Tem ${tasksBox.values.where((todo) => todo.isDone == false).toList().length} tarefas",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: phoneW * 0.03,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
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
          ),
          Flexible(
            child: ListView.builder(
                reverse: false,
                shrinkWrap: true,
                itemCount: tasksBox.length,
                itemBuilder: (context, index) {
                  // BLOC
                  // read
                  final todo = crudOperations.readTodo(index);
                  // update the index
                  crudOperations.updateTodo(
                      index,
                      TodoModel(
                          name: todo.name,
                          notes: todo.notes,
                          index: index,
                          isDone: todo.isDone));
                  // BLOC
                  return _todoList(todo);
                }),
          ),
        ],
      ),
    );
  }

  Widget _todoList(TodoModel todo) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;
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
                    // Navigator.push(
                    //   context,
                    //   CupertinoPageRoute(
                    //     builder: (context) => Dicas(),
                    //   ),
                    // );
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
                    MyFlutterIcons.twitch,
                    color: Cor().customColor,
                    size: phoneW * .062,
                    //color: customColorBody,
                  ),
                  onPressed: () {
                    // BLOC
                    // if (Platform.isAndroid)
                    //   _todoLogic.abrirUrl(todo.taskIcon, context);
                    // else if (Platform.isIOS)
                    //   _todoLogic.abririOS(todo.taskIcon, context);
                    // BLOC
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
                    fontSize: phoneW * .045),
              ),
            )
          : Center(
              child: Text(
                todo.name,
                style: TextStyle(
                    color: Cor().customColorBody, fontSize: phoneW * .045),
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
                    color: Cor().customColorBody, fontSize: phoneW * .045),
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
                name: todo.name,
                notes: todo.notes,
                isDone: !todo.isDone,
              ));
          // BLOC
        },
      ),
      trailing: IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            // BLOC
            crudOperations.deleteTodo(todo.index);
            // BLOC
          }),
      onTap: () {
        print(todo.index);
        _openTodoDialog(todo);
      },
    );
  }

  Future _openTodoDialog(TodoModel todo) {
    final _formKey = GlobalKey<FormState>();
    String taskName = '';
    String taskNote = '';

    List<String> _iconNames = [
      'Nota',
      'Facebook',
      'Instagram',
      'WhatsApp',
      'Youtube',
      'Linkedin',
      'Twitter',
      'Pinterest',
      'Google',
      'Blog',
      'TikTok',
      'Snapchat',
      'SlideShare',
      'Flickr',
    ].toList();
    String _selectionIcon = 'Nota';
    int _iconPriority = 1;

    if (todo != null) {
      taskName = todo.name;
      taskNote = todo.notes;

      //_iconPriority = todo.icon;

      _taskNameController.text = todo.name;
      _taskNoteController.text = todo.notes;
    } else {
      taskName = '';
      taskNote = '';
      _taskNoteController.clear();
      _taskNameController.clear();
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
              'Seu lembrete',
              style: TextStyle(fontFamily: ' Nunito'),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InputDecorator(
                  decoration: InputDecoration(labelText: 'Redes Sociais'),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: true,
                      items: _iconNames.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      value: _iconNames[todo == null
                          ? (_iconPriority - 1)
                          : (todo.icon - 1)],
                      onChanged: (value) async {
                        //_atualizarIcon(value);
                        print(value + ' prioridade ' + '$_iconPriority');
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
                textColor: Cor().customColor,
                // O texto muda de acordo com o todo, se vai criar um novo ou editar
                child: todo == null
                    ? Text('Criar nova tarefa')
                    : Text('Editar tarefa'),
                onPressed: () {
                  if (taskName.trim().length < 1) {
                    Toast.show('Nada escrito!', context,
                        duration: 4,
                        backgroundColor: Colors.grey[300],
                        textColor: Colors.black);
                  }
                  if (todo == null) {
                    _formKey.currentState.save();
                    final newTodo = TodoModel(name: taskName, notes: taskNote);
                    crudOperations.createTodo(newTodo);
                    _formKey.currentState.reset();
                  } else {
                    _formKey.currentState.save();
                    final newTodo = TodoModel(name: taskName, notes: taskNote);
                    crudOperations.updateTodo(todo.index, newTodo);
                    _formKey.currentState.reset();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Hive.box('tasks').compact();
    Hive.close();
    super.dispose();
  }
}
