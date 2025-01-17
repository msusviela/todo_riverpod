import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/providers/providers.dart';
import 'package:todo_app/domain/to_do.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoView extends ConsumerWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final pendingToDos = todos.where((toDo) => !toDo.completed).toList();
    final completedToDos = todos.where((toDo) => toDo.completed).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          onTap: (index) => ref.read(tabIndexProvider.notifier).state = index,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
        body: TabBarView(
          children: [
            _ToDoList(
                toDos: pendingToDos,
                emptyMessage: 'There are no pending tasks'),
            _ToDoList(
                toDos: completedToDos,
                emptyMessage: 'There are no completed tasks'),
          ],
        ),
        floatingActionButton: const AddToDoButton(),
      ),
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
