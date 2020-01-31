import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/chat_module.dart';

class HelpIcon extends StatelessWidget {
  HelpIcon(this.cor);

  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(Icons.live_help),
        iconSize: 35,
        color: cor,
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ChatModule(),
          ),
        ),
      ),
    );
  }
}
