import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/core/locator.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class ToDoStateNotifier extends AsyncNotifier<ToDoState> {
  late final ToDoRepository _toDoRepository = locator<ToDoRepository>();

  @override
  Future<ToDoState> build() async {
    return ToDoState.initial();
  }

  Future<void> loadToDos() async {
    state = const AsyncLoading();
    final toDosResult =
        await AsyncValue.guard(() => _toDoRepository.getToDos());

    state = toDosResult.map(
      data: (data) => AsyncData(ToDoState(toDos: data.value)),
      error: (error) => AsyncError(error.error, error.stackTrace),
      loading: (_) => const AsyncLoading(),
    );
  }

  Future<void> addToDo({required String title}) async {
    try {
      final toDos = state.value!.toDos;
      final newId = toDos.isEmpty ? 1 : toDos.last.id + 1;

      final newToDo = ToDo(
        id: newId,
        title: title,
        completed: false,
      );

      await _toDoRepository.addToDo(newToDo);
      final updatedToDos = List.of(toDos)..add(newToDo);

      state = AsyncData(state.value!.copyWith(toDos: updatedToDos));
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> updateToDo({required ToDo toDo}) async {
    try {
      final toDos = state.value!.toDos;

      await _toDoRepository.updateToDo(toDo);

      final updatedToDos = [
        for (final item in toDos)
          if (item.id == toDo.id) toDo else item,
      ];

      state = AsyncData(state.value!.copyWith(toDos: updatedToDos));
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> deleteToDo({required int id}) async {
    try {
      final toDos = state.value!.toDos;
      await _toDoRepository.deleteToDo(id);
      final updatedToDos = toDos.where((todo) => todo.id != id).toList();
      state = AsyncData(state.value!.copyWith(toDos: updatedToDos));
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
