import 'package:flutter/material.dart';

class EditToDoDialog extends StatelessWidget {
  const EditToDoDialog({
    super.key,
    required this.titleController,
    required this.onEditToDo,
    this.editToDoTitle,
    this.buttonConfirmationText,
  });

  final TextEditingController titleController;
  final Function(String) onEditToDo;
  final String? editToDoTitle;
  final String? buttonConfirmationText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(editToDoTitle ?? 'Update ToDo'),
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
          onPressed: () => onEditToDo(titleController.text.trim()),
          child: Text(buttonConfirmationText ?? 'Update'),
        ),
      ],
    );
  }
}
