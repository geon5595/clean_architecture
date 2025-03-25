import 'package:newproject/core/resources/data_state.dart';
import 'package:newproject/feature/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // api call
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  // local db call
  Future<List<ArticleEntity>> getSavedArticles();

  // local db call
  Future<void> saveArticle(ArticleEntity article);

  // local db call
  Future<void> removeArticle(ArticleEntity article);
}
