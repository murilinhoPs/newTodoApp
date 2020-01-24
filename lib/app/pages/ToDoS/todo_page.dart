import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/body.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/dialogs.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:new_todo_trianons/app/shared/repository/firebase_provider.dart';
import 'package:provider/provider.dart';

class MyTodoPage extends StatefulWidget {
  @override
  _MyTodoPageState createState() => _MyTodoPageState();
}

class _MyTodoPageState extends State<MyTodoPage> {
  final tasksBox = Hive.box('tasks');

  final Dialogs _dialogs = Dialogs();

  final IndexChanges _listenIndex = IndexChanges();

  void _sendScreenInfo(BuildContext context) {
    final Analytics analise = Provider.of<Analytics>(context, listen: false);

    analise.observer.analytics.setCurrentScreen(screenName: 'MyTodoPage');
  }

  @override
  void initState() {
    // tasksBox.clear();
    // Hive.box('indices').clear();
    // _crudIndices.updateIndex(0);
    _listenIndex.initialize(context);
    _sendScreenInfo(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Analytics analise = Provider.of<Analytics>(context, listen: false);
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
      floatingActionButton: SpeedDial(
        child: Icon(Icons.note_add),
        overlayOpacity: 0.5,
        //animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.create),
              label: 'Criar novo',
              onTap: () {
                analise.analytics.logEvent(
                  name: 'Criar ToDo custom',
                  parameters: <String, dynamic>{
                    'criar': 'criou seu todo customizavel'
                  },
                );
                analise.analytics.setCurrentScreen(screenName: 'MyTodoPage');
                _dialogs.openTodoDialog(null, context);
              }),
          SpeedDialChild(
            child: Icon(Icons.add),
            elevation: 0.0,
            onTap: () {
              analise.analytics.logEvent(
                name: 'Criar ToDo template'
              );
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
      body:
          // Consumer do Hive.box(o widget que vai rebuildar quando algum valor no Hive.box('tasks') mudar => ouvir)
          ValueListenableBuilder(
        valueListenable: Hive.box('tasks').listenable(),
        builder: (BuildContext context, Box tasksBox, Widget widget) =>
            BodyApp(),
      ),
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
