import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/features/to_do/presentation/notifiers/to_do_state.dart';
import 'package:todo_app/features/to_do/to_do.dart';

import 'utils/utils.dart';

class MockToDoRepository extends Mock implements ToDoRepository {}

const initialName = 'Test ToDo';

void main() {
  late MockToDoRepository mockRepository;
  late List<ToDo> toDos;

  setUpAll(() {
    registerFallbackValue(
        const ToDo(id: 0, title: 'fallback', completed: false));
  });

  setUp(() {
    mockRepository = MockToDoRepository();
    toDos = [];

    when(() => mockRepository.getToDos()).thenAnswer((_) => toDos);

    when(() => mockRepository.addToDo(any())).thenAnswer((invocation) {
      final todo = invocation.positionalArguments.first as ToDo;
      toDos.add(todo);
    });

    when(() => mockRepository.deleteToDo(any())).thenAnswer((invocation) {
      final id = invocation.positionalArguments.first as int;
      toDos.removeWhere((todo) => todo.id == id);
    });

    when(() => mockRepository.updateToDo(any())).thenAnswer((invocation) {
      final updated = invocation.positionalArguments.first as ToDo;
      toDos = [
        for (final item in toDos)
          if (item.id == updated.id) updated else item
      ];
    });
  });

  test('Must initialize with an empty list', () {
    final container = createContainer(
      overrides: [
        toDoProvider.overrideWith(
            (ref) => ToDoStateNotifier(toDoRepository: mockRepository)),
      ],
    );

    expect(container.read(toDoProvider), const ToDoState(toDos: []));
  });

  test('Must add a ToDo to the provider state', () {
    final container = createContainer(
      overrides: [
        toDoProvider.overrideWith(
            (ref) => ToDoStateNotifier(toDoRepository: mockRepository)),
      ],
    );

    final controller = container.read(toDoProvider.notifier);
    controller.addToDo(title: initialName);

    final toDos = container.read(toDoProvider).toDos;
    expect(toDos.length, 1);
    expect(toDos.first.title, initialName);
  });

  test('Must delete a ToDo from the provider state', () {
    final container = createContainer(
      overrides: [
        toDoProvider.overrideWith(
            (ref) => ToDoStateNotifier(toDoRepository: mockRepository)),
      ],
    );

    final controller = container.read(toDoProvider.notifier);
    controller.addToDo(title: initialName);
    final toDos = container.read(toDoProvider).toDos;
    final toDo = toDos.first;

    controller.deleteToDo(id: toDo.id);

    expect(container.read(toDoProvider), const ToDoState(toDos: []));
  });

  test('Must update ToDo to be completed', () {
    final container = createContainer(
      overrides: [
        toDoProvider.overrideWith(
            (ref) => ToDoStateNotifier(toDoRepository: mockRepository)),
      ],
    );

    final controller = container.read(toDoProvider.notifier);
    controller.addToDo(title: initialName);
    final toDos = container.read(toDoProvider).toDos;
    final toDo = toDos.first;

    final updatedToDo = toDo.copyWith(completed: true);
    controller.updateToDo(toDo: updatedToDo);

    final updatedToDos = container.read(toDoProvider).toDos;
    expect(updatedToDos.first.completed, isTrue);
  });

  test('Must update To Do Title', () {
    final container = createContainer(
      overrides: [
        toDoProvider.overrideWith(
            (ref) => ToDoStateNotifier(toDoRepository: mockRepository)),
      ],
    );

    final controller = container.read(toDoProvider.notifier);
    controller.addToDo(title: initialName);
    final toDo = container.read(toDoProvider).toDos.first;

    const newName = 'New name';
    final updatedToDo = toDo.copyWith(title: newName);
    controller.updateToDo(toDo: updatedToDo);

    final updatedToDos = container.read(toDoProvider).toDos;
    expect(updatedToDos.first.title, equals(newName));
  });
}
