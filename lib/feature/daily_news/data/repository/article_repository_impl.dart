import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newproject/core/constants/constant.dart';
import 'package:newproject/core/resources/data_state.dart';
import 'package:newproject/feature/daily_news/data/data_sources/local/moor_database.dart';
import 'package:newproject/feature/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:newproject/feature/daily_news/data/models/article.dart';
import 'package:newproject/feature/daily_news/domain/entities/article.dart';
import 'package:newproject/feature/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsApiKey,
        country: countryQuery,
        category: categoryQuery,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.map((e) => e.toEntity()).toList());
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.getAllArticles().then(
      (value) => value.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.deleteArticle(article.id!);
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.insertArticle(ArticleModel.fromEntity(article));
  }
}
