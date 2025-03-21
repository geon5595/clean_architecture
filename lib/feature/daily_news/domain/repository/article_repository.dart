import 'package:newproject/core/resources/data_state.dart';
import 'package:newproject/feature/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
