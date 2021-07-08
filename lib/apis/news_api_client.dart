import 'package:dio/dio.dart';
import 'package:news_api_statenotifer_sample/models/article_model.dart';

class NewsApiClient {
  dynamic req({Map<String, dynamic>? query}) async {
    Response<Map> response;

    if (query!.isEmpty) return {};

    try {
      response = await Dio().get('https://newsapi.org/v2/everything',
          queryParameters: query,
          options: Options(
              headers: {'Authorization': ''})); //api key here

      switch (response.data!['status']) {
        case 'ok':
          var articles;
          articles = response.data!['articles']
              .map((json) => Article.fromJson(json))
              .toList();
          return articles;
        case 'error':
          return [];
        default:
          return [];
      }
    } on DioError catch (e) {
      print(e.response!.statusCode.toString());
      print(e.message.toString());
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
