import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) dynamic articles,
    @Default(true) bool hasNext,
    @Default('') String keyword,
  }) = _HomeState;
  factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);
}
