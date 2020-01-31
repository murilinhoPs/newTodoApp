import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:new_todo_trianons/app/pages/chat_page/models/message_model.dart';
import 'package:new_todo_trianons/app/shared/services/dio_response.dart';

import 'package:rxdart/rxdart.dart';

class GetBloc extends BlocBase {
  final _service = DiscordService();

  final _controller$ = BehaviorSubject<List<MessageModel>>();

  Stream get saida => _controller$.stream;
  Sink get entrada => _controller$.sink;

  requisition() async {
    List<MessageModel> response = await _service.responseGet();
    entrada.add(response);
  }

  @override
  void dispose() {
    _controller$.close();
    super.dispose();
  }
}
