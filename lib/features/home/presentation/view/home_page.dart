import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/home.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(toDoProvider.notifier).loadToDos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
