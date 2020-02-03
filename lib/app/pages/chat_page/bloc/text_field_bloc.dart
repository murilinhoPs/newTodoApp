import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:new_todo_trianons/app/pages/chat_page/components/text_form.dart';
import 'package:rxdart/subjects.dart';

class TextBloc extends BlocBase {
  final _forms = TextForms();

  final _controller$ = BehaviorSubject<String>();

  String get controlString => _controller$.value;
  Stream<String> get saida => _controller$.stream;
  Sink get entrada => _controller$.sink;

  changeFormData(String value) {
    _forms.controller.text = value;
    entrada.add(value);

    print(_controller$.value);
    print(_forms.controller.text);
  }

  @override
  void dispose() {
    _controller$.close();
    super.dispose();
  }
}
