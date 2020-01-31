import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/hints/components/back_button.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
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
      appBar: AppBar(
        leading: MyBackButton(
          EdgeInsets.only(bottom: 5.0),
        ),
        title: Text(
          'Tire suas dúvidas aqui!',
          style: TextStyle(
              color: Cor().customColor, fontFamily: 'Nunito', fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder<List<MessageModel>>(
            stream: ChatModule.to.bloc<GetBloc>().saida,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.085),
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              MessageModel item = snapshot.data[index];

                              return MessageTile(
                                item: item,
                              );
                            },
                          ),
                        ),
                        StreamBuilder<int>(
                          stream: blocPost.saida,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) blocPost.entrada.add(null);

                            return TextForms(
                              formController: formController,
                              blocPost: blocPost,
                            );
                          },
                        ),
                      ],
                    )
                  : Center(child: CircularProgressIndicator());
            }),
      ),
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
