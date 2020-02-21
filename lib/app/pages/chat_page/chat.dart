import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/hints/components/back_button.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:new_todo_trianons/app/shared/repository/links_drawer.dart';
import 'bloc/chat_module.dart';
import 'bloc/get_bloc.dart';
import 'bloc/post_bloc.dart';
import 'components/message_tile.dart';
import 'components/text_form.dart';
import 'models/message_model.dart';

class ChatPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ChatPage> {
  Controller formController;

  final blocPost = ChatModule.to.bloc<PostBloc>();

  final links = DrawerLinks();

  @override
  void initState() {
    ChatModule.to.bloc<GetBloc>().requisition();

    formController = Controller();

    // defines a timer
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      ChatModule.to.bloc<GetBloc>().requisition();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3.0,
        leading: MyBackButton(
          EdgeInsets.only(bottom: 5.0),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => links.discord(context),
              child: Image.asset(
                'assets/images/discord.png',
                width: MediaQuery.of(context).size.width * 0.12,
              ),
            ),
          )
        ],
        title: Text(
          'Tire suas dúvidas!',
          style: TextStyle(
              color: Cor().customColor, fontFamily: 'Nunito', fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          bottom: false,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              StreamBuilder<List<MessageModel>>(
                  stream: ChatModule.to.bloc<GetBloc>().saida,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.065),
                            child: ListView.builder(
                              reverse: true,
                              //shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                MessageModel item = snapshot.data[index];

                                return MessageTile(
                                  message: item,
                                );
                              },
                            ),
                          )
                        : Center(child: CircularProgressIndicator());
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                // bottom: 0,
                // top: MediaQuery.of(context).size.height * 0.783,
                // left: 0,
                // right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1.0,
                          color: Colors.black12,
                          blurRadius: 3.0),
                    ],
                  ),
                ),
              ),
              StreamBuilder<int>(
                stream: blocPost.saida,
                builder: (context, snapshot) {
                  return TextForms(
                    formController: formController,
                    blocPost: blocPost,
                  );
                },
              ),
            ],
          )),
    );
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validade() {
    var formState = formKey.currentState;

    if (formState.validate()) {
      formState.save();
      return true;
    } else
      return false;
  }
}
