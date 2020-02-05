//import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/chat_module.dart';
import 'package:provider/provider.dart';

class HelpIcon extends StatelessWidget {
  HelpIcon(this.cor);

  final Color cor;

  _openChat(BuildContext context) {
    final observer =
        Provider.of<FirebaseAnalyticsObserver>(context, listen: false);
    // final fbEvent = FacebookAnalytics();

    observer.analytics.setCurrentScreen(
        screenName: 'DiscordChat', screenClassOverride: 'DiscordChat');
    //fbEvent.logEvent(name: 'DiscordChatPage');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: IconButton(
        icon: Icon(Icons.live_help),
        iconSize: 35,
        color: cor,
        onPressed: () {
          _openChat(context);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ChatModule(),
            ),
          );
        },
      ),
    );
  }
}
