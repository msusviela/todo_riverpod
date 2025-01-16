import 'package:flutter/material.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoDeleteButton extends StatelessWidget {
  const ToDoDeleteButton({
    super.key,
    required this.todo,
    required this.controller,
  });

  final ToDo todo;
  final ToDoController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Color.fromARGB(255, 183, 25, 14)),
      onPressed: () => controller.deleteToDo(id: todo.id),
    );
  }
}
