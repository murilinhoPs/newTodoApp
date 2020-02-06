//import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_appevents/flutter_facebook_appevents.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/chat_module.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/text_field_bloc.dart';
import 'package:new_todo_trianons/app/pages/chat_page/chat.dart';
import 'package:new_todo_trianons/app/pages/chat_page/models/message_model.dart';
import 'package:new_todo_trianons/app/shared/custom/Colors.dart';
import 'package:provider/provider.dart';

class TextForms extends StatelessWidget {
  TextForms({this.formController, this.blocPost});

  final TextEditingController controller = TextEditingController();
  final blocPost;

  final Controller formController;

  //final fbEvent = FacebookAnalytics();

  _onSubmitt(context) {
    if (formController.validade()) {
      var ctrlText = controller.text;
      if (ctrlText.startsWith('@')) {
        var edit = ctrlText.split(' ')[0];

        var fim =
            ctrlText.replaceAll(edit, ChatModule.to.bloc<TextBloc>().idValue);

        print(edit + fim);

        blocPost.content = fim;

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

        ChatModule.to.bloc<TextBloc>().entrada.add(null);
        ChatModule.to.bloc<TextBloc>().idEntry.add(null);

        Provider.of<FirebaseAnalytics>(context)
            .logEvent(name: 'Send_Mention_Message');

        FacebookAppEvents.logEvent('Send_Mention_Message', {});

        controller.clear();

        blocPost.content = null;
      }

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

      ChatModule.to.bloc<TextBloc>().entrada.add(null);
      ChatModule.to.bloc<TextBloc>().idEntry.add(null);

      Provider.of<FirebaseAnalytics>(context).logEvent(name: 'Send_Message');
      FacebookAppEvents.logEvent('Send_Message', {});

      controller.clear();

      blocPost.content = null;
    }
  }

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
                          if (snapshot.hasData)
                            controller.text = '${snapshot.data}';
                          // ${ChatModule.to.bloc<TextBloc>().idValue}';

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
                            onFieldSubmitted: (_) => _onSubmitt(context),
                          );
                        }),
                  ),
                  height: 50,
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 26,
                  onPressed: () => _onSubmitt(context),
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
