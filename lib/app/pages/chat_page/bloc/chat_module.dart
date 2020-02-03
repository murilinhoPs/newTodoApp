import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/get_bloc.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/post_bloc.dart';
import 'package:new_todo_trianons/app/pages/chat_page/bloc/text_field_bloc.dart';
import 'package:new_todo_trianons/app/pages/chat_page/chat.dart';

class ChatModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
          (_) => GetBloc(),
        ),
        Bloc(
          (_) => PostBloc(),
        ),
        Bloc((_) => TextBloc())
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ChatPage();

  static Inject get to => Inject<ChatModule>.of();
}
