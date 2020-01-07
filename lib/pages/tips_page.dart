import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_todo_trianons/bloc/dicas_provider.dart';
import 'package:provider/provider.dart';

class Dicas extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final DicasState dicasProvider = Provider.of<DicasState>(context);

    return Scaffold(
      body: Consumer<DicasState>(
          builder: (context, dicasProvider, widget) => ListView(
                children: <Widget>[
                  ListBody(
                    children: <Widget>[
                      dicasProvider.carregarDicas(dicasProvider.dicas),
                    ],
                  ),
                ],
              )),
      floatingActionButton: FlatButton(
        child: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
    //throw UnimplementedError();
  }
}
