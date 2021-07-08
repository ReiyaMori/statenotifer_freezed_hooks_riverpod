import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_api_statenotifer_sample/models/article_model.dart';
import 'package:news_api_statenotifer_sample/view_models/home_view_model.dart';
import 'package:news_api_statenotifer_sample/views/article_detail_page.dart';

class HomePage extends HookWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('SEARCH NEWS'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[_SearchForm(), Expanded(child: _Articles())],
          ),
        ),
      ),
    );
  }
}

class _SearchForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModel.notifier);
    final state = useProvider(homeViewModel);

    return Container(
      padding: const EdgeInsets.all(5),
      height: 50,
      child: TextFormField(
          controller: TextEditingController(text: state.keyword),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) async {
            await viewModel.setQuery(value);
            viewModel.getArticles();
          },
          decoration:
              InputDecoration(icon: Icon(Icons.search), hintText: 'キーワード')),
    );
  }
}

class _Articles extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModel.notifier);
    final state = useProvider(homeViewModel);

    return RefreshIndicator(
      onRefresh: () async {
        await viewModel.refreshArticles();
      },
      child: Scrollbar(
        child: ListView.builder(
            // controller: _controller,
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              if (state.articles.length == index - 1 && state.hasNext) {
                viewModel.getArticles();
                print('get more ...');
                return const LinearProgressIndicator();
              }
              return _articleItem(
                  article: state.articles[index], context: context);
            }),
      ),
    );
  }

  Widget _articleItem(
      {required Article article, required BuildContext context}) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Material(
          elevation: 5,
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (article.urlToImage != null || article.urlToImage != '')
                      ? Container(
                          child: Image.network(article.urlToImage!),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      article.title ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
        ),
      ),
      onTap: () {
        if (article.url!.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ArticleDetailPage(article: article)));
        }
      },
    );
  }
}
