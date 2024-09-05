import 'package:bloc/bloc.dart';
import 'package:todo_clean_arch/domain/models/todo.dart';

import '../../domain/repository/todo_reop.dart';


class TodoCubit extends Cubit<List<Todo>> {
  TodoRepo todoRepo;
  
  TodoCubit(this.todoRepo) : super([]){
    loadTodos();
  }
  
  // L O A D
  Future<void> loadTodos()async{
    // fetch list of todos from repo
    final todoList = await todoRepo.getTodos();
    
    // emit the fetched list as a new state
    emit(todoList);
  }

  // A D D
  Future<void> addTodo(String text)async{
    // create a new todo with unique id
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);

    // save the new todo to repo
    await todoRepo.addTodo(newTodo);

    // re-load
    loadTodos();

  }

  // D E L E T E
  Future<void> deleteTodo(Todo todo)async{
    // delete todo from repo
    await todoRepo.deleteTodo(todo);

    // re-load
    loadTodos();
  }

  // T O G G L E
  Future<void> toggleCompletion(Todo todo)async{
    // toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    // update the todo in repo
    await todoRepo.updateTodo(updatedTodo);

    // re-load
    loadTodos();
  }
}
