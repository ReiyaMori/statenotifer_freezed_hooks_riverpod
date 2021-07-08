import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
abstract class Article with _$Article {
  factory Article(
      {@JsonKey(name: 'source') Map? source,
      @JsonKey(name: 'author') String? author,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'urlToImage') String? urlToImage,
      @JsonKey(name: 'publishedAt') String? publishedAt,
      @JsonKey(name: 'content') String? content}) = _Article;
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
