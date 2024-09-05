import 'package:isar/isar.dart';
import 'package:todo_clean_arch/data/models/isar_todo.dart';
import 'package:todo_clean_arch/domain/models/todo.dart';
import 'package:todo_clean_arch/domain/repository/todo_reop.dart';

class TodoRepoImpl extends TodoRepo{
  // database
  final Isar db;

  TodoRepoImpl(this.db);

  @override
  Future<void> addTodo(Todo newTodo) {
    // convert todo into isar todo object
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // store the isar object to the database
    return db.writeTxn(() => db.todoIsars.put(todoIsar),);
  }

  @override
  Future<void> updateTodo(Todo todo) {
    // convert todo into isar todo object
    final todoIsar = TodoIsar.fromDomain(todo);

    // store the isar object to the database
    return db.writeTxn(() => db.todoIsars.put(todoIsar),);
  }

  @override
  Future<void> deleteTodo(Todo todo) async{
    await db.writeTxn(() => db.todoIsars.delete(todo.id),);
  }

  @override
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.todoIsars.where().findAll();

    // return as a list of todos and give to domain layer
    return todos.map((todosIsar) => todosIsar.toDomain(),).toList();
  }
}