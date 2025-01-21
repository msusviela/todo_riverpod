import 'package:todo_app/features/to_do/to_do.dart';

class ToDoRepository {
  final List<ToDo> toDos = [];

  Future<List<ToDo>> getToDos() async => toDos;

  Future<void> addToDo(ToDo toDo) async {
    toDos.add(toDo);
  }

  Future<void> updateToDo(ToDo toDo) async {
    final toDoIndex = toDos.indexWhere((e) => e.id == toDo.id);
    toDos[toDoIndex] = toDo;
  }

  Future<void> deleteToDo(int id) async {
    toDos.removeWhere((todo) => todo.id == id);
  }
}
