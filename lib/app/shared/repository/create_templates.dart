import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/indices_provider.dart';
import 'package:provider/provider.dart';
import 'package:new_todo_trianons/app/pages/ToDoS/bloc/drop_icons_provider.dart';
import 'package:toast/toast.dart';
import '../model/todo_model.dart';

class Templates {
  criarTemplate(String value, BuildContext context) {
    final Index testIndex = Provider.of<Index>(context, listen: false);
    final DropdownLinks dropdownState =
        Provider.of<DropdownLinks>(context, listen: false);

    switch (value) {
      case 'Facebook':
        return TodoModel(
          name: 'Falta criatividade? experimente acessar o:',
          notes: 'IMGFLIP.com',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );
        break;
      case 'Instagram':
        return TodoModel(
          name: 'Escolha os filtros com sabedoria e evite usar texto na imagem',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );
        break;
      case 'WhatsApp':
        return TodoModel(
          name:
              'Faça parte de grupos de Whatsapp sobre seu mercado de trabalho!',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );

        break;
      case 'Youtube':
        return TodoModel(
          name: 'Grave transmissões ao vivo e compartilhe!',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );

        break;
      case 'Linkedin':
        return TodoModel(
          name: 'Mantenha seu perfil bem atualizado!',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );
        break;
      case 'Twitter':
        return TodoModel(
          name:
              'O Twitter é um canal que requer tempo e dedicação em tempo real.',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );
        break;
      case 'Pinterest':
        return TodoModel(
          name:
              'Crie álbuns e atualize com inspirações de outra pessoas também.',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );
        break;

      case 'TikTok':
        return TodoModel(
          name: 'Uma nova rede social bem divertida e criativa!',
          notes: '',
          icon: dropdownState.selectionIcon,
          index: testIndex.testIndex++,
        );
        break;
      default:
        return Toast.show('nada para criar...', context);
        break;
      // case 'Lembrete':
      //   return Navigator.of(context).pop();
      //   break;
      // case 'Google':
      //   return Navigator.of(context).pop();
      //   break;
      // case 'Blog':
      //   return Navigator.of(context).pop();
      // case 'Snapchat':
      //   return Navigator.of(context).pop();
      //   break;
      // case 'SlideShare':
      //   return Navigator.of(context).pop();
      //   break;
      // case 'Flickr':
      //   return Navigator.of(context).pop();
      //   break;
    }
  }
}
