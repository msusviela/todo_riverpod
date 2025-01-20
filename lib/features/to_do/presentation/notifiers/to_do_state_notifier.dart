import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/to_do/presentation/notifiers/to_do_state.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoNotifier extends StateNotifier<ToDoState> {
  final ToDoRepository toDoRepository;

  ToDoNotifier(this.toDoRepository)
      : super(ToDoState(toDos: toDoRepository.getToDos()));

  void addToDo({required String title}) {
    final toDos = state.toDos;
    final newId = toDos.isEmpty ? 1 : toDos.last.id + 1;

    final todo = ToDo(
      id: newId,
      title: title,
      completed: false,
    );
    toDoRepository.addToDo(todo);
    state = state.copyWith(toDos: toDoRepository.getToDos().toList());
  }

  void updateToDo({required ToDo toDo}) {
    final toDos = state.toDos;
    toDoRepository.updateToDo(toDo);
    final updatedToDoList = [
      for (final item in toDos)
        if (item.id == toDo.id) toDo else item
    ];
    state = state.copyWith(toDos: updatedToDoList);
  }

  void deleteToDo({required int id}) {
    final toDos = state.toDos;
    toDoRepository.deleteToDo(id);
    final updatedToDoList = toDos.where((todo) => todo.id != id).toList();
    state = state.copyWith(toDos: updatedToDoList);
  }
}
