import 'package:flutter/widgets.dart';

class DropdownLinks extends ChangeNotifier {
  List<String> _iconNames = [
    'Lembrete',
    'Facebook',
    'Instagram',
    'WhatsApp',
    'Youtube',
    'Linkedin',
    'Twitter',
    'Pinterest',
    'Google',
    'Blog',
    'TikTok',
    'Snapchat',
    'SlideShare',
    'Flickr',
  ].toList();

  List<String> get iconNames => _iconNames;

  // PROVIDER
  String _selectionIcon = 'Lembrete';

  String get selectionIcon => _selectionIcon;

  atualizarIcon(String value) {
    switch (value) {
      case 'Lembrete':
        _selectionIcon = value;
        break;
      case 'Facebook':
        _selectionIcon = value;
        break;
      case 'Instagram':
        _selectionIcon = value;
        break;
      case 'Youtube':
        _selectionIcon = value;
        break;
      case 'WhatsApp':
        _selectionIcon = value;
        break;
      case 'TikTok':
        _selectionIcon = value;
        break;
      default:
        _selectionIcon = 'Lembrete';
    }
    notifyListeners();

    print('ICON: $_selectionIcon');
  }
}
