import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/providers/providers.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ToDoTile(todo: todo);
        },
      ),
      floatingActionButton: const AddToDoButton(),
    );
  }
}
