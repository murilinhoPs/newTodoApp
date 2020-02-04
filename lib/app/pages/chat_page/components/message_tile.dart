import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/chat_module.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/text_field_bloc.dart';
import 'package:new_todo_trianons/app/pages/chat_page/models/message_model.dart';

class MessageTile extends StatelessWidget {
  MessageTile({this.message});

  final MessageModel message;

  final String botUser = 'HelpBot';

  _blocData() {
    ChatModule.to
        .bloc<TextBloc>()
        .changeFormData('@${message.author.username}');

    ChatModule.to.bloc<TextBloc>().idEntry.add('<@${message.author.id}>');
  }

  @override
  Widget build(BuildContext context) {
    String _contentText(MessageModel msg) {
      return (msg.content.contains('<@'))
          ? msg.content.replaceAll(
              '<@${msg.mentions[0].id}>', '@${msg.mentions[0].username}')
          : (msg.content.contains('<@!'))
              ? msg.content.replaceAll(
                  '<@!${msg.mentions[0].id}>', '@${msg.mentions[0].username}')
              : msg.content;
    }

    _contentImage(MessageModel file) {
      return file.attachments.length > 0
          ? Image.network(file.attachments[0].url)
          : file.embeds.length > 0
              ? Image.network(file.embeds[0].image.url)
              : Container(
                  height: 0,
                  width: 0,
                );
    }

    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          onTap: () => _blocData(),
          leading: Hero(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://cdn.discordapp.com/avatars/${message.author.id}/${message.author.avatar}.png'),
            ),
            tag: message.author.username,
          ),
          title: Text(message.author.username,
              style: TextStyle(color: Colors.deepPurple[800], fontSize: 16)),
          subtitle: Text(
            _contentText(message),
            style: TextStyle(fontSize: 17, color: Colors.grey[800]),
          ),
        ),
        _contentImage(message)
      ],
    );
  }
}
