import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/providers/providers.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/features/to_do/to_do.dart';

import 'utils/provider_container.dart';

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
        todoProvider.overrideWith((ref) => ToDoController(mockRepository)),
      ],
    );

    expect(container.read(todoProvider), isEmpty);
  });

  test('Must add a ToDo to the provider state', () {
    final container = createContainer(
      overrides: [
        todoProvider.overrideWith((ref) => ToDoController(mockRepository)),
      ],
    );

    final controller = container.read(todoProvider.notifier);
    controller.addToDo(title: initialName);

    expect(container.read(todoProvider).length, 1);
    expect(container.read(todoProvider).first.title, initialName);
  });

  test('Must delete a ToDo from the provider state', () {
    final container = createContainer(
      overrides: [
        todoProvider.overrideWith((ref) => ToDoController(mockRepository)),
      ],
    );

    final controller = container.read(todoProvider.notifier);
    controller.addToDo(title: initialName);
    final toDo = container.read(todoProvider).first;

    controller.deleteToDo(id: toDo.id);

    expect(container.read(todoProvider), isEmpty);
  });

  test('Must update ToDo to be completed', () {
    final container = createContainer(
      overrides: [
        todoProvider.overrideWith((ref) => ToDoController(mockRepository)),
      ],
    );

    final controller = container.read(todoProvider.notifier);
    controller.addToDo(title: initialName);
    final toDo = container.read(todoProvider).first;

    final updatedToDo = toDo.copyWith(completed: true);
    controller.updateToDo(toDo: updatedToDo);

    expect(container.read(todoProvider).first.completed, isTrue);
  });

  test('Must update To Do Title', () {
    final container = createContainer(
      overrides: [
        todoProvider.overrideWith((ref) => ToDoController(mockRepository)),
      ],
    );

    final controller = container.read(todoProvider.notifier);
    controller.addToDo(title: initialName);
    final toDo = container.read(todoProvider).first;

    const newName = 'New name';
    final updatedToDo = toDo.copyWith(title: newName);
    controller.updateToDo(toDo: updatedToDo);

    expect(container.read(todoProvider).first.title, equals(newName));
  });
}
