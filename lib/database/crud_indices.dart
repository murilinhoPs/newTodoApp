import 'package:hive/hive.dart';

class TodoIndicesCrud {
  final Box<dynamic> _indicesBox = Hive.box('indices');

  updateIndex(int index) {
    _indicesBox.put('tasksIndices', index);
  }

  readIndex() {
    return _indicesBox.get('tasksIndices');
  }
}
