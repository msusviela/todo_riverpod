import 'package:todo_app/features/to_do/to_do.dart';

class ToDoRepository {
  final List<ToDo> toDos = [];

  List<ToDo> getToDos() => toDos;

  void addToDo(ToDo toDo) {
    toDos.add(toDo);
  }

  void updateToDo(ToDo toDo) {
    final toDoIndex = toDos.indexWhere((e) => e.id == toDo.id);
    toDos[toDoIndex] = toDo;
  }

  void deleteToDo(int id) {
    toDos.removeWhere((todo) => todo.id == id);
  }
}
