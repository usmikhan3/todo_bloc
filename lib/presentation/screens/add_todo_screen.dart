import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:todo_bloc/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
            return;
          } else if (state is AddTodoError) {
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
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Enter Todo Message...",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _addButton(context)
      ],
    );
  }

  Widget _addButton(context) {
    return InkWell(
      onTap: () {
        final message = _controller.text;
        BlocProvider.of<AddTodoCubit>(context).addTodo(message);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: BlocBuilder<AddTodoCubit, AddTodoState>(
            builder: (context, state) {
              if ((state is AddingTodo)) {
                return Center(child: CircularProgressIndicator());
              }
              return const Text(
                "Add Todo",
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
