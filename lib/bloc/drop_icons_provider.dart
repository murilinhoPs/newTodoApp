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
    _selectionIcon = value;

    notifyListeners();

    //print('ICON: $_selectionIcon');
  }
}
