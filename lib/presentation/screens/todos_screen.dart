import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/constants/strings.dart';
import 'package:todo_bloc/cubit/todos_cubit.dart';
import 'package:todo_bloc/data/models/todo.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ADD_TODO_ROUTE,
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (!(state is TodosLoaded)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final todos = (state as TodosLoaded).todos;
          return SingleChildScrollView(
            child: Column(
              children: todos!.map((e) => _todo(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _todo(Todo todo, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EDIT_TODO_ROUTE, arguments: todo);
      },
      child: Dismissible(
        key: Key("${todo.id}"),
        child: _todoTile(todo, context),
        background: Container(
          color: Colors.indigo,
        ),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
      ),
    );
  }

  Widget _todoTile(Todo todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("${todo.todoMessage}"), _completionIndicator(todo)],
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border:
              Border.all(color: todo.isCompleted! ? Colors.green : Colors.red)),
    );
  }
}
