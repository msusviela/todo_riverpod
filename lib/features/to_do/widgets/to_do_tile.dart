import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/providers/providers.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoTile extends ConsumerWidget {
  const ToDoTile({
    super.key,
    required this.todo,
  });

  final ToDo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(todoControllerProvider.notifier);

    return ListTile(
      title: Text(todo.title),
      trailing: _ToDoOptions(todo: todo, controller: controller),
    );
  }
}

class _ToDoOptions extends StatelessWidget {
  const _ToDoOptions({
    required this.todo,
    required this.controller,
  });

  final ToDo todo;
  final ToDoController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        ToDoCheckbox(todo: todo, controller: controller),
        const SizedBox(width: 4),
        ToDoDeleteButton(todo: todo, controller: controller),
      ],
    );
  }
}
