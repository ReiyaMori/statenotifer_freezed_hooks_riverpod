import 'package:news_api_statenotifer_sample/apis/news_api_client.dart';

class ArticleRepository {
  final _api = NewsApiClient();
  dynamic fetchArticles(Map<String, dynamic> query) async {
    return await _api.req(query: query);
  }
}
