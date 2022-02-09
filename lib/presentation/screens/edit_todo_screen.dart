import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_bloc/cubit/edit_todo_cubit.dart';
import 'package:todo_bloc/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage!;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Fluttertoast.showToast(
            msg: state.error.toString(),
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16.0,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
            )
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Enter Todo Message",
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          _updateButton(context)
        ],
      ),
    );
  }

  Widget _updateButton(context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<EditTodoCubit>(context)
            .updateTodo(todo, _controller.text);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Update Todo",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
