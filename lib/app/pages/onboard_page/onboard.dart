import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/todo_page.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:new_todo_trianons/app/shared/repository/crud_boolean.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen(this.skip);

  bool skip;

  List<PageViewModel> _listPages(context) {
    return [
      // 01
      PageViewModel(
        title: " ",
        body: " ",
        image: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image.asset(
            'assets/screens/01.png',
          ),
        ),
        decoration: PageDecoration(
          pageColor: Color.fromRGBO(216, 212, 226, 1),
          imagePadding: EdgeInsets.zero,
          imageFlex: 100,
        ),
      ),

      // 02
      PageViewModel(
        title: " ",
        body: " ",
        image: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image.asset(
            'assets/screens/02.png',
          ),
        ),
        decoration: PageDecoration(
          pageColor: Color.fromRGBO(216, 212, 226, 1),
          imagePadding: EdgeInsets.zero,
          imageFlex: 100,
        ),
      ),

      // 03
      PageViewModel(
        title: " ",
        body: " ",
        image: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image.asset(
            'assets/screens/03.png',
          ),
        ),
        decoration: PageDecoration(
          pageColor: Color.fromRGBO(216, 212, 226, 1),
          imagePadding: EdgeInsets.zero,
          imageFlex: 100,
        ),
      ),

      // 04
      PageViewModel(
        title: " ",
        body: " ",
        image: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image.asset(
            'assets/screens/04.png',
          ),
        ),
        decoration: PageDecoration(
          pageColor: Color.fromRGBO(216, 212, 226, 1),
          imagePadding: EdgeInsets.zero,
          imageFlex: 100,
        ),
      ),

      // 05
      PageViewModel(
        title: " ",
        body: " ",
        image: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image.asset(
            'assets/screens/05.png',
          ),
        ),
        decoration: PageDecoration(
          pageColor: Color.fromRGBO(216, 212, 226, 1),
          imagePadding: EdgeInsets.zero,
          imageFlex: 100,
        ),
      ),

      // 06
      PageViewModel(
        title: " ",
        body: " ",
        image: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Image.asset(
            'assets/screens/06.png',
          ),
        ),
        decoration: PageDecoration(
          pageColor: Color.fromRGBO(216, 212, 226, 1),
          imagePadding: EdgeInsets.zero,
          imageFlex: 100,
        ),
      ),
    ];
  }

  _pagePush(context) {
    Navigator.pushAndRemoveUntil(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(
                builder: (context) => MyTodoPage(),
              )
            : MaterialPageRoute(
                builder: (context) => MyTodoPage(),
              ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(216, 212, 226, 1),
      body: IntroductionScreen(
        dotsFlex: 2,
        curve: Curves.ease,
        globalBackgroundColor: Color.fromRGBO(216, 212, 226, 1),
        pages: _listPages(context),
        dotsDecorator: DotsDecorator(
          spacing: EdgeInsets.all(5.0),
          activeColor: Cor().appBarGradientCima,
          activeSize: Size.square(15.0),
        ),
        onDone: () {},
        done: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
          elevation: 0.0,
          color: Cor().appBarGradientCima,
          onPressed: () {
            OnboardBox.setToFalse();
            _pagePush(context);
          },
          child: Text(
            'Pronto!',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 15),
          ),
        ),
        showSkipButton: skip,
        skip: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
          elevation: 0.0,
          color: Cor().appBarGradientCima,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Pular',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
