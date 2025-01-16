import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/locator.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/domain/domain.dart';

import '../../features/to_do/to_do.dart';

final todoControllerProvider =
    StateNotifierProvider<ToDoController, List<ToDo>>(
  (ref) => ToDoController(locator<ToDoRepository>()),
);
