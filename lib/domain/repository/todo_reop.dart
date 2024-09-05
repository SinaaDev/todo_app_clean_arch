import 'package:todo_clean_arch/domain/models/todo.dart';

abstract class TodoRepo{

  // get list of todos
  Future<List<Todo>> getTodos();

  // add new todo
  Future<void> addTodo(Todo newTodo);

  // update an existing todo
  Future<void> updateTodo(Todo todo);

  // delete todo
  Future<void> deleteTodo(Todo todo);

}