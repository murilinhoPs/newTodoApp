import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/components/help_icon.dart';
import 'package:new_todo_trianons/app/pages/hints/components/back_button.dart';
import 'package:new_todo_trianons/app/pages/hints/dicas_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Dicas extends StatelessWidget {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<ui.Image> _loadErnesto() async {
    ByteData bd = await rootBundle.load('assets/ernesto.png');

    final Uint8List bytes = Uint8List.view(bd.buffer);

    final ui.Codec codec = await ui.instantiateImageCodec(bytes);

    final ui.Image image = (await codec.getNextFrame()).image;

    return image;
  }

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
      body: FutureBuilder<ui.Image>(
        future: _loadErnesto(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );

          if (snapshot.hasData)
            return CustomPaint(
              painter: BaloonPainter(snapshot.data),
              child: Consumer<DicasState>(
                builder: (context, dicasProvider, widget) => Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(phoneW * .1),
                    child: Column(
                      children: <Widget>[
                        ListBody(
                          children: <Widget>[
                            dicasProvider.carregarDicas(
                                'Facebook'), //dicasProvider.dicas
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

          return CircularProgressIndicator();
        },
      ),
    );
    //throw UnimplementedError();
  }
}

class BaloonPainter extends CustomPainter {
  BaloonPainter(this.image);

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromLTRBR(
      25,
      10,
      390,
      530,
      Radius.circular(30),
    );
    final paint = Paint()
      ..color = Colors.orange[100]
      ..strokeWidth = 50.0;

    canvas.drawRRect(rrect, paint);
    canvas.drawLine(Offset(330, 531), Offset(100, 400), paint);

    canvas.scale(size.width / (image.width.toDouble()) / 2.2);

    canvas.drawImage(
      image,
      Offset(630, 1540),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
