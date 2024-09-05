import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/todo.dart';
import '../../domain/repository/todo_reop.dart';
import '../bloc/todo_cubit.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo;

  const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),

          // add button
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // todo cubit
    final todoCubit = context.read<TodoCubit>();

    // SCAFFOLD
    return Scaffold(
      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoBox(context),
        child: const Icon(Icons.add),
      ),

      // BLOC BUILDER
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // List View
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual todo from todos list
              final todo = todos[index];

              // List Tile UI
              return ListTile(
                // text
                title: Text(
                  todo.text,
                  style: TextStyle(
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),

                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                // delete button
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => todoCubit.deleteTodo(todo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}