import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/constants/strings.dart';
import 'package:todo_bloc/cubit/add_todo_cubit.dart';
import 'package:todo_bloc/cubit/edit_todo_cubit.dart';
import 'package:todo_bloc/cubit/todos_cubit.dart';
import 'package:todo_bloc/data/models/todo.dart';
import 'package:todo_bloc/data/network_service.dart';
import 'package:todo_bloc/data/respository.dart';
import 'package:todo_bloc/presentation/screens/add_todo_screen.dart';
import 'package:todo_bloc/presentation/screens/edit_todo_screen.dart';
import 'package:todo_bloc/presentation/screens/todos_screen.dart';

class MyRouter {
  Repository? repository;
  TodosCubit? todosCubit;

  MyRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository);
  }
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todosCubit!,
            child: TodosScreen(),
          ),
        );
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                EditTodoCubit(repository: repository, todosCubit: todosCubit),
            child: EditTodoScreen(
              todo: todo,
            ),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AddTodoCubit(repository: repository, todosCubit: todosCubit),
            child: AddTodoScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => TodosScreen());
    }
  }
}
