import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_clean_arch/data/repository/todo_repo_impl.dart';
import 'package:todo_clean_arch/domain/repository/todo_reop.dart';
import 'package:todo_clean_arch/presentation/screens/todo_screen.dart';

import 'data/models/isar_todo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized() ;
  // get directory path for the storing data
  final dir = await getApplicationDocumentsDirectory();

  // open isar database
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // initialize the repo with the isar database
  final isarTodoRepo = TodoRepoImpl(isar);

  // run app
  runApp( MyApp(todoRepo: isarTodoRepo,));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key,required this.todoRepo});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
