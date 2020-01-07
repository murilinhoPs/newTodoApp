import 'package:hive/hive.dart';

class TodoIndicesCrud{
  final Box<dynamic> _indicesBox = Hive.box('indices');
  

  updateIndex(int index){
    _indicesBox.put('tasksIndices', index);
    print(_indicesBox.values);
  }

  readIndex(){
    return _indicesBox.get('tasksIndices');
  } 
}