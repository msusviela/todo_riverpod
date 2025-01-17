import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoNotifier extends StateNotifier<List<ToDo>> {
  final ToDoRepository toDoRepository;

  ToDoNotifier(this.toDoRepository) : super(toDoRepository.getToDos());

  void addToDo({required String title}) {
    final newId = state.isEmpty ? 1 : state.last.id + 1;

    final todo = ToDo(
      id: newId,
      title: title,
      completed: false,
    );
    toDoRepository.addToDo(todo);
    state = toDoRepository.getToDos().toList();
  }

  void updateToDo({required ToDo toDo}) {
    toDoRepository.updateToDo(toDo);
    state = [
      for (final item in state)
        if (item.id == toDo.id) toDo else item
    ];
  }

  void deleteToDo({required int id}) {
    toDoRepository.deleteToDo(id);
    state = state.where((todo) => todo.id != id).toList();
  }
}
