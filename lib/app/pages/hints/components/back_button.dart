import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';

class MyBackButton extends StatelessWidget {
  MyBackButton(this.padding);

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        margin: EdgeInsets.all(5.0),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        color: Cor().appBarGradientCima,
        child: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            size: 18,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
