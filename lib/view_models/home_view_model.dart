import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_api_statenotifer_sample/repositories/article_repository.dart';
import 'package:news_api_statenotifer_sample/states/home_state.dart';

final StateNotifierProvider<HomeViewModel, HomeState> homeViewModel =
    StateNotifierProvider((_) => HomeViewModel(ArticleRepository()));

class HomeViewModel extends StateNotifier<HomeState> {
  final ArticleRepository repository;
  HomeViewModel(this.repository) : super(HomeState()) {
    getArticles();
  }

  int _page = 1;
  bool _isLoading = false;

  Future<dynamic> getArticles() async {
    if (!state.hasNext || _isLoading) return;
    _isLoading = true;

    final List articles =
        await repository.fetchArticles({'page': _page, 'q': state.keyword});

    final newArticles = [...state.articles, ...articles];

    if (articles.length == 0 || articles.isEmpty) {
      state = state.copyWith(hasNext: false);
    }

    // state 更新
    state = state.copyWith(articles: newArticles);

    _page++;
    _isLoading = false;
  }

  Future<void> setQuery(String keyword) async {
    state = state.copyWith(
      articles: [],
      keyword: keyword,
      hasNext: true,
    );

    _page = 1;
  }

  Future<void> refreshArticles() async {
    state = state.copyWith(
      articles: [],
      hasNext: true,
    );

    _page = 1;

    this.getArticles();
  }
}
