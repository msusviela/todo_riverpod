import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/locator.dart';
import 'package:todo_app/features/to_do/presentation/notifiers/to_do_state.dart';
import 'package:todo_app/features/to_do/to_do.dart';

final todoProvider = StateNotifierProvider<ToDoNotifier, ToDoState>(
  (ref) => ToDoNotifier(locator<ToDoRepository>()),
);
