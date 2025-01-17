import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/providers/providers.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class AddToDoButton extends ConsumerWidget {
  const AddToDoButton({
    super.key,
  });

  void _addToDo({
    required BuildContext context,
    required ToDoController controller,
    required String title,
  }) {
    if (title.isNotEmpty) {
      controller.addToDo(title: title);
      Navigator.pop(context);
    }
  }

  void _showAddToDoDialog({
    required BuildContext context,
    required ToDoController controller,
  }) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditToDoDialog(
          titleController: titleController,
          editToDoTitle: 'Add ToDo',
          buttonConfirmationText: 'Add',
          onEditToDo: (title) {
            _addToDo(context: context, controller: controller, title: title);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(todoProvider.notifier);

    return FloatingActionButton(
      onPressed: () => _showAddToDoDialog(
        context: context,
        controller: controller,
      ),
      child: const Icon(Icons.add),
    );
  }
}
