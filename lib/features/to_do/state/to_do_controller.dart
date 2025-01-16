import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/domain/domain.dart';

class ToDoController extends StateNotifier<List<ToDo>> {
  final ToDoRepository toDoRepository;

  ToDoController(this.toDoRepository) : super(toDoRepository.getToDos());

  void addToDo({required String title}) {
    final newId = state.isEmpty ? 0 : state.last.id + 1;

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
