import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

extension HomeStateX on HomeState {
  HomeState updateIndex(int index) => copyWith(tabIndex: index);
}

@Freezed(
  fromJson: false,
  toJson: false,
  toStringOverride: false,
)
class HomeState with _$HomeState {
  const factory HomeState({
    required int tabIndex,
  }) = _HomeState;
}
