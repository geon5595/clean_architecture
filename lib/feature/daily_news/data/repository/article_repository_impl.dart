import 'package:newproject/feature/daily_news/domain/entities/article.dart';
import 'package:newproject/feature/daily_news/domain/repository/article_repository.dart';

abstract class ArticleRepositoryImpl implements ArticleRepository {
  Future<List<ArticleEntity>> getArticles();
}
