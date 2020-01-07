import 'package:new_todo_trianons/custom/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class DicasState extends ChangeNotifier {
  String _dicas = 'Lembrete';

  String get dicas => _dicas;

  set dicas(String value) {
    _dicas = value;

    notifyListeners();
    print(_dicas);
  }

  carregarDicas(String value) {
    switch (value) {
      case 'Facebook':
        return Column(
          children: <Widget>[
            Text('Fuja do conteúdo padrão (imagem + texto)'),
            Text(
                'Experimente criar conteúdo em formatos diferentes. Que tal experimentar um vídeo ou uma transmissão ao vivo. ')
          ],
        );

        break;
      case 'Instagram':
        return Text('Use imagens bonitas, coloridas e com alta definição.');

        break;
      case 'WhatsApp':
        return (MyFlutterIcons.whatsapp);
        break;
      case 'Youtube':
        return Text(
            'Youtube é o site de vídeos mais acessado do mundo. Aqui, a regra é não ter vergonha de gravar um vídeo nem que seja um material curto de 3 minutos.');

        break;
      case 'Linkedin':
        return Text(
            'Um bom artigo pode ser uma excelente maneira para alcançar pessoas relevantes no seu segmento profissional.');
        break;
      case 'Twitter':
        return (MyFlutterIcons.twitter);
        break;
      case 'Pinteres':
        return (MyFlutterIcons.pinterest);
        break;
      case 'Google':
        return (MyFlutterIcons.google);
        break;
      case 'Blog':
        return (MyFlutterIcons.blogger);
        break;
      case 'TikTok':
        return (MyFlutterIcons.tik_tok);
        break;
      case 'Snapchat':
        return (MyFlutterIcons.snapchat_ghost);
        break;
      case 'SlideShare':
        return (MyFlutterIcons.slideshare);
        break;
      case 'Flickr':
        return (MyFlutterIcons.flickr);
        break;
    }
  }
}
