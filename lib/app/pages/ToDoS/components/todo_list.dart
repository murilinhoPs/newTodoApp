//import 'package:facebook_analytics/facebook_analytics.dart';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_appevents/flutter_facebook_appevents.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/dialogs.dart';
import 'package:new_todo_trianons/app/pages/hints/dicas_provider.dart';
import 'package:new_todo_trianons/app/pages/hints/tips_page.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:new_todo_trianons/app/shared/custom/my_flutter_app_icons.dart';
import 'package:new_todo_trianons/app/shared/model/todo_model.dart';
import 'package:new_todo_trianons/app/shared/repository/crud_database.dart';
import 'package:new_todo_trianons/app/shared/repository/crud_indices.dart';
import 'package:new_todo_trianons/app/shared/services/open_links.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ToDoList extends StatelessWidget {
  ToDoList({this.todo});

  final TodoModel todo;

  final CardLinks todosIcons = CardLinks();
  final TodoCrud crudOperations = TodoCrud();
  final TodoIndicesCrud _crudIndices = TodoIndicesCrud();
  final Dialogs _dialogs = Dialogs();
  //final fbEvent = FacebookAnalytics();

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    final DicasState dicasProvider =
        Provider.of<DicasState>(context, listen: false);

    final FirebaseAnalyticsObserver observer =
        Provider.of<FirebaseAnalyticsObserver>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(phoneW * .07))),
      margin: EdgeInsets.all(phoneW * .025),
      child: Column(
        children: <Widget>[
          _todoListTile(todo, context),
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
                      FacebookAppEvents.logEvent('Dicas_Page', {});
                      observer.analytics.setCurrentScreen(
                          screenName: 'Dicas', screenClassOverride: 'Dicas()');
                      Navigator.push(
                        context,
                        Platform.isIOS
                            ? CupertinoPageRoute(
                                builder: (context) => Dicas(),
                              )
                            : MaterialPageRoute(
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
                    //fbEvent.logEvent(name: 'Open_External_App');
                    // Provider.of<FirebaseAnalytics>(context, listen: false)
                    //     .logEvent(name: 'Open_External_App');
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

  Widget _todoListTile(TodoModel todo, BuildContext context) {
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
          if (!todo.isDone) {
            FacebookAppEvents.logEvent('Completed_ToDo', {});
            Provider.of<FirebaseAnalytics>(context, listen: false)
                .logEvent(name: 'Completed_ToDo');
          }
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
            FacebookAppEvents.logEvent('Deletou_ToDo', {});
            Provider.of<FirebaseAnalytics>(context, listen: false)
                .logEvent(name: 'Deletou_ToDo');
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
}
