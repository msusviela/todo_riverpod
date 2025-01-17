import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/features/to_do/to_do.dart';

class MockToDoRepository extends Mock implements ToDoRepository {}

class FakeToDo extends Fake implements ToDo {}

void main() {
  late MockToDoRepository mockToDoRepository;
  final List<ToDo> mockToDos = [];

  Widget buildApp() {
    return ProviderScope(
      overrides: [
        todoProvider.overrideWith(
          (ref) => ToDoNotifier(mockToDoRepository),
        ),
      ],
      child: const MaterialApp(home: ToDoView()),
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeToDo());
    mockToDoRepository = MockToDoRepository();

    when(() => mockToDoRepository.getToDos()).thenAnswer((_) => mockToDos);

    when(() => mockToDoRepository.addToDo(any())).thenAnswer((invocation) {
      final todo = invocation.positionalArguments.first as ToDo;
      mockToDos.add(todo);
    });
  });

  tearDown(() {
    mockToDos.clear();
  });

  group('ToDoView Tests', () {
    testWidgets('Add a ToDo and display it in the Pending Tab', (tester) async {
      await tester.pumpWidget(buildApp());

      final addButtonFinder = find.byIcon(Icons.add);
      await tester.tap(addButtonFinder);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'New Task');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(find.text('New Task'), findsOneWidget);
    });
  });

  testWidgets('Mark ToDo as completed and move it to the Completed Tab',
      (tester) async {
    mockToDos.add(const ToDo(
      id: 1,
      title: 'Task 1',
      completed: false,
    ));

    await tester.pumpWidget(buildApp());
    expect(find.widgetWithText(ListTile, 'Task 1'), findsOneWidget);

    final checkboxFinder = find.descendant(
      of: find.widgetWithText(ListTile, 'Task 1'),
      matching: find.byType(Checkbox),
    );

    expect(checkboxFinder, findsOneWidget);
    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, 'Task 1'), findsOneWidget);
  });

  testWidgets('Delete a ToDo and verify it is removed from both tabs',
      (tester) async {
    mockToDos.add(const ToDo(
      id: 1,
      title: 'Task 1',
      completed: false,
    ));
    await tester.pumpWidget(buildApp());

    expect(find.text('Task 1'), findsOneWidget);

    await tester.drag(find.text('Task 1'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text("Are you sure you want to delete this task?"),
        findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Task 1'), findsNothing);

    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();
    expect(find.text('Task 1'), findsNothing);
  });

  testWidgets('Edit a ToDo and verify the title is updated', (tester) async {
    mockToDos.add(const ToDo(
      id: 1,
      title: 'Task 1',
      completed: false,
    ));
    await tester.pumpWidget(buildApp());

    expect(find.text('Task 1'), findsOneWidget);

    await tester.drag(find.text('Task 1'), const Offset(500, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Updated Task');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Update'));
    await tester.pumpAndSettle();

    expect(find.text('Updated Task'), findsOneWidget);
    expect(find.text('Task 1'), findsNothing);
  });
}
