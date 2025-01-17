import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/home.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: const ToDoView(),
        floatingActionButton: const AddToDoButton(),
      ),
    );
  }
}
