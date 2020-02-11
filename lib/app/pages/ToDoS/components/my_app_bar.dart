import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/help_icon.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    final phoneH = MediaQuery.of(context).size.height;

    return AppBar(
      iconTheme: IconThemeData(color: Colors.white, size: 2.0),
      actions: <Widget>[
        HelpIcon(Colors.white),
      ],
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
      centerTitle: true,
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
    );
  }
}
