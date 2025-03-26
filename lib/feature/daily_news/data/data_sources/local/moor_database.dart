import 'package:drift/drift.dart';
import 'package:newproject/feature/daily_news/data/models/article.dart';

part 'moor_database.g.dart';

class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get author => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get url => text().nullable()();
  TextColumn get urlToImage => text().nullable()();
  TextColumn get publishedAt => text().nullable()();
  TextColumn get content => text().nullable()();
}

@DriftDatabase(tables: [Articles])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  // DB -> ArticleModel 매핑
  ArticleModel articleFromDB(Article article) {
    return ArticleModel(
      id: article.id,
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );
  }

  // ArticleModel을 ArticlesCompanion으로 변환하는 메서드
  ArticlesCompanion articleModelToCompanion(ArticleModel model) {
    return ArticlesCompanion(
      author: Value(model.author),
      title: Value(model.title),
      description: Value(model.description),
      url: Value(model.url),
      urlToImage: Value(model.urlToImage),
      publishedAt: Value(model.publishedAt),
      content: Value(model.content),
    );
  }

  Future<List<ArticleModel>> getAllArticles() async {
    final articlesList = await select(articles).get();
    return articlesList.map((article) => articleFromDB(article)).toList();
  }

  Future<int> insertArticle(ArticleModel article) =>
      into(articles).insert(articleModelToCompanion(article));

  Future<void> deleteArticle(int id) =>
      (delete(articles)..where((a) => a.id.equals(id))).go();
}
