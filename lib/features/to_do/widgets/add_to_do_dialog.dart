import 'package:flutter/material.dart';

class AddToDoDialog extends StatelessWidget {
  const AddToDoDialog({
    super.key,
    required this.titleController,
    required this.onAddToDo,
  });

  final TextEditingController titleController;
  final Function(String) onAddToDo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add ToDo'),
      content: TextField(
        controller: titleController,
        decoration: const InputDecoration(
          hintText: 'Enter description',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => onAddToDo(titleController.text.trim()),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
