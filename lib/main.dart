import 'package:flutter/material.dart';
import 'package:todo_bloc/presentation/routes.dart';
import 'package:todo_bloc/presentation/screens/todos_screen.dart';

void main() {
  runApp(TodoApp(
    router: MyRouter(),
  ));
}

class TodoApp extends StatelessWidget {
  final MyRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO BLOC PATTERN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generateRoute,
    );
  }
}
