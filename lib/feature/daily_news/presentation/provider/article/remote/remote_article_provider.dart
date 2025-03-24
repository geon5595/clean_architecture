import 'package:flutter/material.dart';
import 'package:newproject/core/resources/data_state.dart';
import 'package:newproject/feature/daily_news/domain/usecases/get_article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_event.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_state.dart';
import 'package:dio/dio.dart';

class RemoteArticleProvider extends ChangeNotifier {
  RemoteArticleState _state = const RemoteArticlesLoading();
  RemoteArticleState get state => _state;

  final GetArticleUseCase _getArticleUseCase;
  RemoteArticleProvider(this._getArticleUseCase) {
    onEvent(const GetArticles());
  }

  void onEvent(RemoteArticleEvent event) {
    if (event is GetArticles) {
      onGetArticles();
    }
  }

  Future<void> onGetArticles() async {
    try {
      _state = const RemoteArticlesLoading();
      notifyListeners();

      final response = await _getArticleUseCase();

      if (response is DataSuccess) {
        _state = RemoteArticlesDone(response.data!);
      } else if (response is DataFailed) {
        print(response.error);
        _state = RemoteArticlesError(response.error!);
      }

      notifyListeners();
    } catch (e) {
      print(e);
      _state = RemoteArticlesError(e as DioException);
      notifyListeners();
    }
  }
}
