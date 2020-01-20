import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/hints/dicas_provider.dart';
import 'package:provider/provider.dart';

class Dicas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final DicasState dicasProvider = Provider.of<DicasState>(context);
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 3.0,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            size: 20),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
    //throw UnimplementedError();
  }
}
