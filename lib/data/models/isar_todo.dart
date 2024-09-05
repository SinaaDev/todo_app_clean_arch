import 'package:isar/isar.dart';

import '../../domain/models/todo.dart';
// to generate isar todo object run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar{
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convert isar object => todo object
   Todo toDomain(){
     return Todo(id: id, text: text,isCompleted: isCompleted);
   }

  // convert todo object => isar object
  static TodoIsar fromDomain(Todo todo){
     return TodoIsar()
         ..id = todo.id
         ..text = todo.text
         ..isCompleted = todo.isCompleted;
  }
}