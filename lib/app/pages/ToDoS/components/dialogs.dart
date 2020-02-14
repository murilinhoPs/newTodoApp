//import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_appevents/flutter_facebook_appevents.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/shared/repository/create_templates.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/drop_icons_provider.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:new_todo_trianons/app/shared/model/todo_model.dart';
import 'package:new_todo_trianons/app/shared/repository/crud_database.dart';
import 'package:new_todo_trianons/app/shared/repository/crud_indices.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Dialogs {
  final TodoCrud _crudOperations = TodoCrud();
  final TodoIndicesCrud _crudIndices = TodoIndicesCrud();
  //final fbEvent = FacebookAnalytics();

  Future openTodoDialog(TodoModel todo, BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController _taskNameController = TextEditingController();
    TextEditingController _taskNoteController = TextEditingController();

    String taskName = '';
    String taskNote = '';

    final DropdownLinks dropdownState =
        Provider.of<DropdownLinks>(context, listen: false);

    final Index testIndex = Provider.of<Index>(context, listen: false);

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
                      ? Text(
                          'Criar nova tarefa',
                          style: TextStyle(fontSize: 18),
                        )
                      : Text(
                          'Editar tarefa',
                          style: TextStyle(fontSize: 18),
                        ),
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
                          index: testIndex.testIndex++);
                      _crudOperations.createTodo(newTodo);
                      _crudIndices.updateIndex(
                          testIndex.testIndex); // atualiza o index no db
                      // BLOC
                      _formKey.currentState.reset();

                      Provider.of<FirebaseAnalytics>(context, listen: false)
                          .logEvent(name: 'Criou_ToDo_Custom');

                      FacebookAppEvents.logEvent('Criou_ToDo_Custom', {});
                    } else {
                      _formKey.currentState.save();
                      // BLOC
                      final newTodo = TodoModel(
                          name: taskName,
                          notes: taskNote,
                          icon: dropdownState.selectionIcon,
                          index: todo.index);

                      _crudOperations.updateTodo(todo.index, newTodo);
                      // BLOC
                      _formKey.currentState.reset();
                      Provider.of<FirebaseAnalytics>(context, listen: false)
                          .logEvent(name: 'Editou_ToDo');
                      FacebookAppEvents.logEvent('Editou_ToDo', {});
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

  Future openTemplateDialog(TodoModel todo, BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final Templates template = Templates();

    final DropdownLinks dropdownState =
        Provider.of<DropdownLinks>(context, listen: false);

    final Index testIndex = Provider.of<Index>(context, listen: false);

    final phoneH = MediaQuery.of(context).size.height;

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
              content: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: phoneH * 0.02),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Adicione uma tarefa pronta para ajudar em alguma rede social',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
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
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  textColor: Cor().customColor,
                  child: Text('Criar tarefa'),
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (dropdownState.selectionIcon == 'Facebook' ||
                        dropdownState.selectionIcon == 'Instagram' ||
                        dropdownState.selectionIcon == 'WhatsApp' ||
                        dropdownState.selectionIcon == 'Youtube' ||
                        dropdownState.selectionIcon == 'Linkedin' ||
                        dropdownState.selectionIcon == 'Twitter' ||
                        dropdownState.selectionIcon == 'Pinterest' ||
                        dropdownState.selectionIcon == 'TikTok') {
                      // BLOC
                      print('criou');
                      await _crudOperations.createTodo(template.criarTemplate(
                          dropdownState.selectionIcon, context));
                      _crudIndices.updateIndex(testIndex.testIndex);
                      // BLOC
                      _formKey.currentState.reset();

                      Provider.of<FirebaseAnalytics>(context, listen: false)
                          .logEvent(name: 'Criou_Todo_Template');
                      FacebookAppEvents.logEvent('Criou_Todo_Template', {});
                    } else {
                      Toast.show('nada para criar...', context);
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
}
