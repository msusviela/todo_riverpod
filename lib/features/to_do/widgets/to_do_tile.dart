import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  void _editToDo(BuildContext context, ToDoController controller) {
    final titleController = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (context) => EditToDoDialog(
        titleController: titleController,
        onEditToDo: (updatedTitle) {
          if (updatedTitle.isNotEmpty && updatedTitle != todo.title) {
            controller.updateToDo(toDo: todo.copyWith(title: updatedTitle));
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(todoControllerProvider.notifier);

    return Slidable(
      key: ValueKey(todo.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => _editToDo(context, controller),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => _confirmDelete(context, controller),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(todo.title),
        trailing: ToDoCheckbox(todo: todo, controller: controller),
      ),
    );
  }
}
