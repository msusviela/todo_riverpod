import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/to_do/to_do.dart';

final toDoProvider = AsyncNotifierProvider<ToDoStateNotifier, ToDoState>(
  ToDoStateNotifier.new,
);
