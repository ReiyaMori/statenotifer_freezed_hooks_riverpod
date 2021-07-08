// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HomeState _$_$_HomeStateFromJson(Map<String, dynamic> json) {
  return _$_HomeState(
    articles: json['articles'] ?? [],
    hasNext: json['hasNext'] as bool? ?? true,
    keyword: json['keyword'] as String? ?? '',
  );
}

Map<String, dynamic> _$_$_HomeStateToJson(_$_HomeState instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'hasNext': instance.hasNext,
      'keyword': instance.keyword,
    };
