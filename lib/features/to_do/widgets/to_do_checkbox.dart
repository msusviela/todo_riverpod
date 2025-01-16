import 'package:flutter/material.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/extensions/extensions.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoCheckbox extends StatelessWidget {
  const ToDoCheckbox({
    super.key,
    required this.todo,
    required this.controller,
  });

  final ToDo todo;
  final ToDoController controller;

  void _showSnackBar(BuildContext context, String message, bool isCompleted) {
    ScaffoldMessenger.of(context).showSnackBar(
      ToDoSnackBar(
        isSuccess: isCompleted,
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: todo.completed,
      onChanged: (_) {
        final completedStatus = !todo.completed;
        controller.updateToDo(toDo: todo.copyWith(completed: completedStatus));
        _showSnackBar(
            context,
            completedStatus ? 'Task completed' : 'Task pending',
            completedStatus);
      },
    );
  }
}
