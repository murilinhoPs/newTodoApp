import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_todo_trianons/app/pages/hints/dicas_provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/dialogs.dart';
import 'package:new_todo_trianons/app/shared/services/open_links.dart';
import 'package:new_todo_trianons/app/shared/database/crud_indices.dart';
import 'package:new_todo_trianons/app/shared/model/todo_model.dart';
import 'package:new_todo_trianons/app/pages/hints/tips_page.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';

import 'package:new_todo_trianons/app/shared/custom/my_flutter_app_icons.dart';
import 'package:new_todo_trianons/app/shared/database/crud_database.dart';

class MyTodoPage extends StatefulWidget {
  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final TodoCrud crudOperations = TodoCrud();
  final TodoIndicesCrud _crudIndices = TodoIndicesCrud();

  final tasksBox = Hive.box('tasks');

  final CardLinks todosIcons = CardLinks();

  final Dialogs _dialogs = Dialogs();

  final IndexChanges _listenIndex = IndexChanges();

  @override
  void initState() {
    // tasksBox.clear();
    // Hive.box('indices').clear();
    // _crudIndices.updateIndex(0);
    _listenIndex.initialize(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

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
      body:
          // Consumer do Hive.box(o widget que vai rebuildar quando algum valor no Hive.box('tasks') mudar => ouvir)
          ValueListenableBuilder(
              valueListenable: Hive.box('tasks').listenable(),
              builder: (BuildContext context, Box tasksBox, Widget widget) =>
                  _beforeTodoList(context)),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.note_add),
        overlayOpacity: 0.5,
        //animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.create),
              label: 'Criar novo',
              onTap: () => _dialogs.openTodoDialog(null, context)),
          SpeedDialChild(
            child: Icon(Icons.add),
            elevation: 0.0,
            onTap: () {
              // Toast.show('Não interativo...', context,
              //     duration: 2,
              //     backgroundColor: Colors.grey[300],
              //     textColor: Colors.black);

              _dialogs.openTemplateDialog(null, context);
            },
            label: 'Criar template',
            //backgroundColor: Colors.grey[300],
          ),
        ],
      ),
    );
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

                      _listenIndex.verifyIndices(index, todo, context);

                      // print('builderLenght: ${tasksBox.length}');
                      // print('saveIndex: ${_crudIndices.readIndex()}');
                      return _todoList(todo);
                    })
                : Center(
                    child: Text('Escreva sua primeira tarefa'),
                  ),
          ),
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

    final Index testIndex = Provider.of<Index>(context, listen: false);

    return ListTile(
      title: todo.isDone
          ? Center(
              child: Text(
                todo.name,
                softWrap: true,
                textAlign: TextAlign.center,
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
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Cor().customColorBody, fontSize: phoneW * .05),
              ),
            ),
      subtitle: todo.isDone
          ? Center(
              child: Text(
                todo.notes,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Cor().customColorBody,
                    color: Colors.grey[500],
                    fontSize: phoneW * .04),
              ),
            )
          : Center(
              child: Text(
                todo.notes,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Cor().customColorBody.shade700,
                    fontSize: phoneW * .04),
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
          onPressed: () async {
            crudOperations.deleteTodo(todo.index);

            await _crudIndices.updateIndex(
                _crudIndices.readIndex() - 1); // atualiza o valor no db
            testIndex.testIndex = _crudIndices
                .readIndex(); // atualiza o valor do provider com o db

            //print('test:$testIndex + indicesDb: ${_crudIndices.readIndex()}');
          }),
      onTap: () {
        _dialogs.openTodoDialog(todo, context);
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
