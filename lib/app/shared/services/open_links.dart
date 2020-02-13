import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_todo_trianons/app/shared/custom/my_flutter_app_icons.dart';
import 'package:new_todo_trianons/app/shared/model/todo_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class CardLinks {
  showError(BuildContext context) {
    return Toast.show('Não foi possível comunicar com o servidor', context,
        duration: 2,
        backgroundColor: Colors.grey[300],
        textColor: Colors.black);
  }

  IconData renderIcon(String value) {
    switch (value) {
      case 'Lembrete':
        return Icons.note;
        break;
      case 'Facebook':
        return (MyFlutterIcons.facebook);
        break;
      case 'Instagram':
        return (MyFlutterIcons.instagram);
        break;
      case 'WhatsApp':
        return (MyFlutterIcons.whatsapp);
        break;
      case 'Youtube':
        return (MyFlutterIcons.youtube_play);
        break;
      case 'Linkedin':
        return (MyFlutterIcons.linkedin_rect);
        break;
      case 'Twitter':
        return (MyFlutterIcons.twitter);
        break;
      case 'Pinterest':
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

  Future _abrirAndroidUrl(String value, context) async {
    switch (value) {
      case 'Lembrete':
        Toast.show('Apenas uma nota lembrete', context,
            duration: 2,
            backgroundColor: Colors.grey[300],
            textColor: Colors.black);
        break;
      case 'Facebook':
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
      case 'Instagram':
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
      case 'WhatsApp':
        if (await canLaunch('https://whatsapp.com/')) {
          try {
            await launch(
              'whatsapp://app',
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
      case 'Youtube':
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
      case 'TikTok':
        if (await canLaunch('https://www.tiktok.com/pt_BR/')) {
          try {
            await launch(
              'musically://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.tiktok.com/pt_BR/',
                enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Pinterest':
        if (await canLaunch('https://br.pinterest.com/')) {
          try {
            await launch(
              'pinterest://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://br.pinterest.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Linkedin':
        if (await canLaunch('https://www.linkedin.com/')) {
          try {
            await launch(
              'linkedin://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.linkedin.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Twitter':
        if (await canLaunch('https://twitter.com/')) {
          try {
            await launch(
              'twitter://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://twitter.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Twitter':
        if (await canLaunch('https://google.com/')) {
          try {
            await launch(
              'google://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://google.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Blog':
        if (await canLaunch('https://www.blogger.com/about/?r=1-null_user')) {
          try {
            await launch(
              'https://www.blogger.com/about/?r=1-null_user',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.blogger.com/about/?r=1-null_user',
                enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Snapchat':
        if (await canLaunch('https://www.snapchat.com/l/pt-br/')) {
          try {
            await launch(
              'snapchat://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.snapchat.com/l/pt-br/',
                enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'SlideShare':
        if (await canLaunch('https://pt.slideshare.net/')) {
          try {
            await launch(
              'slideshare://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://pt.slideshare.net/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'Flickr':
        if (await canLaunch('https://www.flickr.com/')) {
          try {
            await launch(
              'flickr://',
              enableJavaScript: true,
            );
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.flickr.com/', enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
    }
  }

  Future _abrirIosUrl(String value, context) async {
    switch (value) {
      case 'Lembrete':
        Toast.show('Apenas uma nota padrão', context,
            duration: 2,
            backgroundColor: Colors.grey[300],
            textColor: Colors.black);
        break;
      case 'Facebook':
        if (await canLaunch('https://www.facebook.com/')) {
          try {
            await launch('facebook://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            await launch('https://www.facebook.com/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Instagram':
        if (await canLaunch('https://www.instagram.com/')) {
          try {
            await launch('instagram://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            await launch(
              'https://www.instagram.com/',
            );
          }
        } else {
          showError(context);
        }
        break;
      case 'WhatsApp':
        if (await canLaunch('https://whatsapp.com/')) {
          try {
            await launch('whatsapp://app',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            await launch('https://whatsapp.com/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Youtube':
        if (await canLaunch('https://www.youtube.com/')) {
          try {
            await launch('youtube://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.youtube.com/');
          }
        } else {
          showError(context);
        }

        break;

      case 'TikTok':
        if (await canLaunch('https://www.tiktok.com/pt_BR/')) {
          try {
            await launch('musically://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.tiktok.com/pt_BR/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Pinterest':
        if (await canLaunch('https://br.pinterest.com/')) {
          try {
            await launch('pinterest://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print(e.message);
            await launch('https://br.pinterest.com/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Linkedin':
        if (await canLaunch('https://www.linkedin.com/')) {
          try {
            await launch('linkedin://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.linkedin.com/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Twitter':
        if (await canLaunch('https://twitter.com/')) {
          try {
            await launch('twitter://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://twitter.com/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Twitter':
        if (await canLaunch('https://google.com/')) {
          try {
            await launch('google://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://google.com/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Blog':
        if (await canLaunch('https://www.blogger.com/about/?r=1-null_user')) {
          try {
            await launch('https://www.blogger.com/about/?r=1-null_user',
                forceSafariVC: true);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch(
              'https://www.blogger.com/about/?r=1-null_user',
            );
          }
        } else {
          showError(context);
        }
        break;
      case 'Snapchat':
        if (await canLaunch('https://www.snapchat.com/l/pt-br/')) {
          try {
            await launch('snapchat://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.snapchat.com/l/pt-br/',
                enableJavaScript: true);
          }
        } else {
          showError(context);
        }
        break;
      case 'SlideShare':
        if (await canLaunch('https://pt.slideshare.net/')) {
          try {
            await launch('slideshare://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://pt.slideshare.net/');
          }
        } else {
          showError(context);
        }
        break;
      case 'Flickr':
        if (await canLaunch('https://www.flickr.com/')) {
          try {
            await launch('flickr://',
                universalLinksOnly: true, forceSafariVC: false);
          } catch (e) {
            print("ERRO android " + e.message);
            await launch('https://www.flickr.com/');
          }
        } else {
          showError(context);
        }
        break;
    }
  }

  platformOpenUrl(BuildContext context, TodoModel todo) {
    Platform.isIOS
        ? _abrirAndroidUrl(todo.icon, context)
        : _abrirIosUrl(todo.icon, context);
  }
}
