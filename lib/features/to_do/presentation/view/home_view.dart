import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDos = ref.watch(toDoProvider).toDos;
    final pendingToDos = toDos.where((toDo) => !toDo.completed).toList();
    final completedToDos = toDos.where((toDo) => toDo.completed).toList();

    return TabBarView(
      children: [
        _ToDoList(
            toDos: pendingToDos, emptyMessage: 'There are no pending tasks'),
        _ToDoList(
            toDos: completedToDos,
            emptyMessage: 'There are no completed tasks'),
      ],
    );
  }
}

class _ToDoList extends StatelessWidget {
  const _ToDoList({required this.toDos, required this.emptyMessage});

  final List<ToDo> toDos;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return toDos.isEmpty
        ? Center(child: Text(emptyMessage))
        : ListView.builder(
            itemCount: toDos.length,
            itemBuilder: (context, index) {
              return ToDoTile(todo: toDos[index]);
            },
          );
  }
}
