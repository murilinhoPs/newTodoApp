import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/chat_module.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/text_field_bloc.dart';
import 'package:new_todo_trianons/app/pages/chat_page/chat.dart';
import 'package:new_todo_trianons/app/pages/chat_page/models/mentions_model.dart';
import 'package:new_todo_trianons/app/pages/chat_page/models/message_model.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';

class TextForms extends StatelessWidget {
  TextForms({this.formController, this.blocPost});

  final TextEditingController controller = TextEditingController();
  final blocPost;

  final Controller formController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 0.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Form(
                    key: formController.formKey,
                    child: StreamBuilder<String>(
                        stream: ChatModule.to.bloc<TextBloc>().saida,
                        builder: (context, snapshot) {
                          // controller.text =
                          //     snapshot.data;

                          //TODO: Mostre o username; Delete o username quando mandar; enviar o Id;

                          return TextFormField(
                            controller: controller,
                            style: TextStyle(decoration: TextDecoration.none),
                            decoration: InputDecoration(
                              hintText: 'Escreva alguma coisa',
                            ),
                            autocorrect: false,
                            validator: (value) =>
                                value.isEmpty ? 'Deve escrever algo...' : null,
                            onSaved: (value) => blocPost.content = value,
                            onFieldSubmitted: (_) async {
                              if (formController.validade()) {
                                controller.clear();
                                blocPost.entrada.add(
                                  MessageModel(
                                    content: blocPost.content,
                                    // embed: Embeds(
                                    //   title: 'Embed message',
                                    //   description: 'hdhdhdhd',
                                    //   image: Thumbnail(
                                    //       url:
                                    //           'https://i.pinimg.com/originals/ce/2b/27/ce2b274fa68d234865a6abf69644f472.png'),
                                    // ),
                                  ),
                                );

                                blocPost.content = null;
                                blocPost.entrada.add(null);
                              }
                            },
                          );
                        }),
                  ),
                  height: 50,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 28,
                  onPressed: () async {
                    if (formController.validade()) {
                      blocPost.entrada.add(
                        MessageModel(
                          content: blocPost.content,
                          // embed: Embeds(
                          //   image: Thumbnail(
                          //       url:
                          //           'https://i.pinimg.com/originals/ce/2b/27/ce2b274fa68d234865a6abf69644f472.png'),
                          // ),
                        ),
                      );

                      controller.clear();

                      blocPost.content = null;
                      blocPost.entrada.add(null);
                    }
                  },
                  color: Cor().customColorBody,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
