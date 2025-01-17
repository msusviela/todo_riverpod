import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_do.freezed.dart';

@freezed
class ToDo with _$ToDo {
  const factory ToDo({
    required int id,
    required String title,
    required bool completed,
  }) = _ToDo;
}
