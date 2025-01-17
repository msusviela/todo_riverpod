import 'package:get_it/get_it.dart';
import 'package:todo_app/features/to_do/to_do.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ToDoRepository>(() => ToDoRepository());
}
