import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/to_do/presentation/notifiers/to_do_state.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoStateNotifier extends StateNotifier<ToDoState> {
  ToDoStateNotifier({required this.toDoRepository})
      : super(ToDoState.initial());

  final ToDoRepository toDoRepository;

  Future<void> loadToDos() async {
    final toDos = await toDoRepository.getToDos();
    state = state.copyWith(toDos: toDos);
  }

  Future<void> addToDo({required String title}) async {
    final toDos = state.toDos;
    final newId = toDos.isEmpty ? 1 : toDos.last.id + 1;

    final todo = ToDo(
      id: newId,
      title: title,
      completed: false,
    );
    await toDoRepository.addToDo(todo);
    final updatedToDos = List.of(toDos)..add(todo);

    state = state.copyWith(toDos: updatedToDos);
  }

  Future<void> updateToDo({required ToDo toDo}) async {
    final toDos = state.toDos;
    await toDoRepository.updateToDo(toDo);
    final updatedToDoList = [
      for (final item in toDos)
        if (item.id == toDo.id) toDo else item
    ];
    state = state.copyWith(toDos: updatedToDoList);
  }

  Future<void> deleteToDo({required int id}) async {
    final toDos = state.toDos;
    await toDoRepository.deleteToDo(id);
    final updatedToDoList = toDos.where((todo) => todo.id != id).toList();
    state = state.copyWith(toDos: updatedToDoList);
  }
}
