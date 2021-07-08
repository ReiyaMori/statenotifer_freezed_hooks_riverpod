import 'package:flutter/material.dart';
import 'package:news_api_statenotifer_sample/models/article_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatelessWidget {
  static const String routeName = '/article_detail';
  final Article article;

  ArticleDetailPage({required this.article}) : super();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title ?? 'NEWS'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: (article.urlToImage != null)
                          ? Image.network(article.urlToImage!)
                          : Container(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: <Widget>[
                          Text(article.source!['name'] ?? '',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              )),
                          Text(article.publishedAt ?? '',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Material(
                  elevation: 5,
                  child: WebView(
                    initialUrl: article.url,
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
