import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/to_do.dart';
import 'package:todo_app/to_do/to_do.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    final controller = ref.read(todoControllerProvider.notifier);

    return Scaffold(
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: _ToDoOptions(todo: todo, controller: controller),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddToDoDialog(context, controller),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddToDoDialog(BuildContext context, ToDoController controller) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _AddToDoDialog(
          titleController: titleController,
          onAddToDo: (title) {
            if (title.isNotEmpty) {
              controller.addToDo(title: title);
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}

class _AddToDoDialog extends StatelessWidget {
  const _AddToDoDialog({
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
        _ToDoCheckbox(todo: todo, controller: controller),
        const SizedBox(width: 4),
        _ToDoDeleteButton(todo: todo, controller: controller),
      ],
    );
  }
}

class _ToDoCheckbox extends StatelessWidget {
  const _ToDoCheckbox({
    required this.todo,
    required this.controller,
  });

  final ToDo todo;
  final ToDoController controller;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: todo.completed,
      onChanged: (_) => controller.updateToDo(toDo: todo),
    );
  }
}

class _ToDoDeleteButton extends StatelessWidget {
  const _ToDoDeleteButton({
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
