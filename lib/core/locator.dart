import 'package:get_it/get_it.dart';
import 'package:todo_app/data/data.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ToDoRepository>(() => ToDoRepository());
}
