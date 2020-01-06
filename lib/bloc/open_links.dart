import 'package:flutter/material.dart';
import 'package:new_todo_trianons/custom/my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class CardLinks {
  showError(BuildContext context) {
    return Toast.show('Não foi possível comunicar com o servidor', context,
        duration: 5,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black);
  }

  IconData dicaIcon(int value) => MyFlutterIcons.lamp;

  IconData redeSocialIcon(int value) {
    switch (value) {
      case 1:
        return Icons.note;
        break;
      case 2:
        return (MyFlutterIcons.facebook);
        break;
      case 3:
        return (MyFlutterIcons.instagram);
        break;
      case 4:
        return (MyFlutterIcons.whatsapp);
        break;
      case 5:
        return (MyFlutterIcons.youtube_play);
        break;
      case 6:
        return (MyFlutterIcons.linkedin_rect);
        break;
      case 7:
        return (MyFlutterIcons.twitter);
        break;
      case 8:
        return (MyFlutterIcons.pinterest);
        break;
      case 9:
        return (MyFlutterIcons.google);
        break;
      case 10:
        return (MyFlutterIcons.blogger);
        break;
      case 11:
        return (MyFlutterIcons.tik_tok);
        break;
      case 12:
        return (MyFlutterIcons.snapchat_ghost);
        break;
      case 13:
        return (MyFlutterIcons.slideshare);
        break;
      case 14:
        return (MyFlutterIcons.flickr);
        break;
    }
  }

  Future abrirAndroidUrl(int value, context) async {
    switch (value) {
      case 1:
        Toast.show('Apenas uma nota lembrete', context,
            duration: 4,
            backgroundColor: Colors.grey[300],
            textColor: Colors.black);
        break;
      case 2:
        if (await canLaunch('https://www.facebook.com/')) {
          try {
            await launch('fb://', enableJavaScript: true);
          } catch (e) {
            print('Erro android ' + e.message);
            await launch('https://www.facebook.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 3:
        if (await canLaunch('https://www.instagram.com/')) {
          try {
            await launch(
              'instagram://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRORRRRR" + e.message);
            await launch('https://www.instagram.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 4:
        if (await canLaunch('https://whatsapp.com/')) {
          try {
            await launch(
              'whatsapp://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://whatsapp.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 5:
        if (await canLaunch('https://www.youtube.com/')) {
          try {
            await launch(
              'youtube://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.youtube.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 11:
        if (await canLaunch('https://www.tiktok.com/pt_BR/')) {
          try {
            await launch(
              'musically://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.youtube.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      default:
        if (await canLaunch('https://www.flutter.dev/')) {
          await launch('https://www.flutter.dev/', enableJavaScript: true);
        } else {
          showError(context);
        }
        break;
    }
  }

  Future abrirIosUrl(int value, context) async {
    switch (value) {
      case 1:
        Toast.show('Apenas uma nota padrão', context,
            duration: 4,
            backgroundColor: Colors.grey[300],
            textColor: Colors.black);
        break;
      case 2:
        if (await canLaunch('https://www.facebook.com/')) {
          await launch('facebook://', universalLinksOnly: true);

          await launch('https://www.facebook.com/');
        } else {
          showError(context);
        }
        break;
      case 3:
        if (await canLaunch('https://www.instagram.com/')) {
          await launch('instagram://', universalLinksOnly: true);

          await launch(
            'https://www.instagram.com/',
            forceSafariVC: false,
          );
        } else {
          showError(context);
        }
        break;
      case 4:
        if (await canLaunch('https://whatsapp.com/')) {
          await launch('whatsapp://', universalLinksOnly: false);

          await launch('https://whatsapp.com/');
        } else {
          showError(context);
        }
        break;
      case 5:
        if (await canLaunch('https://www.youtube.com/')) {
          await launch('youtube://', universalLinksOnly: false);

          await launch('https://www.youtube.com/');
        } else {
          showError(context);
        }
        break;
      default:
        if (await canLaunch('https://flutter.dev/')) {
          await launch('youtube://', universalLinksOnly: false);

          await launch('https://flutter.dev/', forceSafariVC: true);
        } else {
          showError(context);
        }
        break;
    }
  }
}
