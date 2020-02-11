import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:new_todo_trianons/app/shared/repository/links_drawer.dart';

class MyDrawer extends StatelessWidget {
  final links = DrawerLinks();

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;

    return Drawer(
      elevation: 5,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  alignment: Alignment.center,
                  scale: phoneW * 0.008,
                  filterQuality: FilterQuality.high,
                )
              ],
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
          ListTile(
            leading: Icon(
              Icons.new_releases,
              size: 34,
              color: Cor().appBarGradientCima,
            ),
            title: Text('O que há de novo'),
            onTap: () {
              Navigator.pop(context);
              links.updates(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.grey[400],
              size: 34,
            ),
            title: Text(
              'Tutorial do app',
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            //onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.explore,
              size: 34,
              color: Cor().appBarGradientCima,
            ),
            title: Text('Site Trianons'),
            onTap: () {
              Navigator.pop(context);
              links.saite(context);
            },
          ),
          ListTile(
            leading: Image.asset(
              '/Users/trianonsmps/development/projetosFlutter/newTodoApp/assets/images/discord.png',
              width: phoneW * 0.08,
            ),
            title: Text('Discord Trianons'),
            onTap: () {
              Navigator.pop(context);
              links.discord(context);
            },
          ),
        ],
      ),
    );
  }
}
