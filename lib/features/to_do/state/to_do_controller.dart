import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/domain/domain.dart';

class ToDoController extends StateNotifier<List<ToDo>> {
  final ToDoRepository toDoRepository;
  int currentId = 0;

  ToDoController(this.toDoRepository) : super(toDoRepository.getToDos());

  void addToDo({required String title}) {
    final todo = ToDo(
      id: ++currentId,
      title: title,
      completed: false,
    );
    toDoRepository.addToDo(todo);
    state = [...state, todo];
  }

  void updateToDo({required ToDo toDo}) {
    final updatedToDo = toDo.copyWith(completed: !toDo.completed);
    toDoRepository.updateToDo(updatedToDo);
    state = [
      for (final item in state)
        if (item.id == updatedToDo.id) updatedToDo else item
    ];
  }

  void deleteToDo({required int id}) {
    toDoRepository.deleteToDo(id);
    state = state.where((todo) => todo.id != id).toList();
  }
}
