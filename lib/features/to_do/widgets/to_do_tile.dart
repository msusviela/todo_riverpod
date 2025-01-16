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

  void _confirmDelete(BuildContext context, ToDoController controller) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete To Do"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              controller.deleteToDo(id: todo.id);
              Navigator.of(context).pop(true);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(todoControllerProvider.notifier);

    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: const Color.fromARGB(255, 191, 48, 38),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        _confirmDelete(context, controller);
        return null;
      },
      onDismissed: (_) {
        controller.deleteToDo(id: todo.id);
      },
      child: ListTile(
        title: Text(todo.title),
        trailing: ToDoCheckbox(todo: todo, controller: controller),
      ),
    );
  }
}
