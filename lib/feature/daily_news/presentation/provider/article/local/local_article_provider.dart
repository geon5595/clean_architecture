import 'package:flutter/foundation.dart';
import 'package:newproject/core/resources/data_state.dart';
import 'package:newproject/feature/daily_news/domain/usecases/get_saved_article.dart';
import 'package:newproject/feature/daily_news/domain/usecases/remove_article.dart';
import 'package:newproject/feature/daily_news/domain/usecases/save_article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_event.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_state.dart';

class LocalArticleProvider extends ChangeNotifier {
  LocalArticleState _state = const LocalArticlesLoading();

  LocalArticleState get state => _state;

  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleProvider(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) {
    onEvent(const GetSavedArticles());
  }

  void onEvent(LocalArticleEvent event) {
    if (event is GetSavedArticles) {
      onGetSavedArticles();
    } else if (event is RemoveArticle) {
      onRemoveArticle(event);
    } else if (event is SaveArticle) {
      onSaveArticle(event);
    }
  }

  Future<void> onGetSavedArticles() async {
    _state = const LocalArticlesLoading();
    notifyListeners();

    final articles = await _getSavedArticleUseCase();
    _state = LocalArticlesDone(articles);
    notifyListeners();
  }

  Future<void> onRemoveArticle(RemoveArticle event) async {
    _state = const LocalArticlesLoading();
    notifyListeners();

    await _removeArticleUseCase(params: event.article);
    await onGetSavedArticles();
  }

  Future<void> onSaveArticle(SaveArticle event) async {
    _state = const LocalArticlesLoading();
    notifyListeners();

    await _saveArticleUseCase(params: event.article);
    await onGetSavedArticles();
  }
}
