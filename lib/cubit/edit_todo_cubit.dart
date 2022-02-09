import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/cubit/todos_cubit.dart';
import 'package:todo_bloc/data/models/todo.dart';
import 'package:todo_bloc/data/respository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository? repository;
  final TodosCubit? todosCubit;
  EditTodoCubit({this.repository, this.todosCubit}) : super(EditTodoInitial());

  void deleteTodo(Todo todo) {
    repository!.deleteTodo(todo.id).then((isDelted) {
      if (isDelted) {
        todosCubit!.deleteTodo(todo);
        emit(TodoEdited());
      }
    });
  }

  void updateTodo(Todo todo, String message) {
    if (message.isEmpty) {
      emit(EditTodoError(error: "Message is Empty"));
      return;
    }
    repository!.updateTodo(message, todo.id).then((isEdited) {
      if (isEdited) {
        todo.todoMessage = message;
        todosCubit!.updateTodoList();
        emit(TodoEdited());
      }
    });
  }
}
