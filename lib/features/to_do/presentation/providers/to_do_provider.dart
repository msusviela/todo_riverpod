import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/locator.dart';
import 'package:todo_app/features/to_do/to_do.dart';

final todoProvider = StateNotifierProvider<ToDoNotifier, List<ToDo>>(
  (ref) => ToDoNotifier(locator<ToDoRepository>()),
);
