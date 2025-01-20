import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/features/to_do/to_do.dart';

part 'to_do_state.freezed.dart';

@Freezed(
  fromJson: false,
  toJson: false,
  toStringOverride: false,
)
class ToDoState with _$ToDoState {
  const factory ToDoState({
    required List<ToDo> toDos,
  }) = _ToDoState;
}
