import 'package:hive/hive.dart';

class OnboardBox {
  static final _onboardBox = Hive.box('onboarding');

  static setToFalse() {
    _onboardBox.put('bool', false);
  }

  static getValue() {
    return _onboardBox.get('bool');
  }
}
