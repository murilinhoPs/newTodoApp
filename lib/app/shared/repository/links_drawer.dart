import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/updates_page/main_screen.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerLinks {
  showError(context) {
    return Toast.show('Não foi possível comunicar com o servidor', context,
        duration: 2,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black);
  }

  Future<void> saite(context) async {
    await canLaunch('https://trianons.com.br/trianons-anos-20/');
    try {
      await launch(
        'https://www.trianons.com.br/trianons-anos-20',
        enableJavaScript: true,
      );
    } catch (e) {
      showError(context);
    }
  }

  Future<void> discord(context) async {
    await canLaunch('https://discord.gg/SJjgGuw');
    try {
      await launch(
        'https://discord.gg/SJjgGuw',
        enableJavaScript: true,
      );
    } catch (e) {
      showError(context);
    }
  }

  updates(context) {
    Navigator.push(
      context,
      Platform.isIOS
          ? CupertinoPageRoute(
              builder: (context) => Updates(),
            )
          : MaterialPageRoute(
              builder: (context) => Updates(),
            ),
    );
  }
}
