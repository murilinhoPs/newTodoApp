import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/help_icon.dart';
import 'package:new_todo_trianons/app/pages/hints/components/back_button.dart';
import 'package:new_todo_trianons/app/pages/hints/dicas_provider.dart';
import 'package:provider/provider.dart';

class Dicas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(
          EdgeInsets.only(left: 3.0),
        ),
        actions: <Widget>[
          HelpIcon(Colors.black),
        ],
        automaticallyImplyLeading: false,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10.0),
          child: Container(
            child: Divider(
              indent: 50.0,
              endIndent: 50.0,
              thickness: 2.0,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: phoneH * 0.03,
            ),
            Center(
              child: Text(
                'Dicas!',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  //color: Cor().customColor
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<DicasState>(
        builder: (context, dicasProvider, widget) => Center(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(phoneW * .1),
            child: Column(
              children: <Widget>[
                ListBody(
                  children: <Widget>[
                    dicasProvider.carregarDicas(dicasProvider.dicas),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: phoneH * 0.05),
                  height: phoneW * 0.15,
                  child: Center(
                    child: Text(
                      'Em breve teremos mais dicas!',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //throw UnimplementedError();
  }
}
