import 'package:flutter/material.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoCheckbox extends StatelessWidget {
  const ToDoCheckbox({
    super.key,
    required this.todo,
    required this.controller,
  });

  final ToDo todo;
  final ToDoController controller;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: todo.completed,
      onChanged: (_) => controller.updateToDo(
          toDo: todo.copyWith(completed: !todo.completed)),
    );
  }
}
