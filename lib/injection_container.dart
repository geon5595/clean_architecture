import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:newproject/core/constants/constant.dart';
import 'package:newproject/feature/daily_news/data/data_sources/local/database_connection.dart';
import 'package:newproject/feature/daily_news/data/data_sources/local/moor_database.dart';
import 'package:newproject/feature/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:newproject/feature/daily_news/data/repository/article_repository_impl.dart';
import 'package:newproject/feature/daily_news/domain/repository/article_repository.dart';
import 'package:newproject/feature/daily_news/domain/usecases/get_article.dart';
import 'package:newproject/feature/daily_news/domain/usecases/get_saved_article.dart';
import 'package:newproject/feature/daily_news/domain/usecases/remove_article.dart';
import 'package:newproject/feature/daily_news/domain/usecases/save_article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_provider.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  final database = AppDatabase(openConnection());
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  final dio = Dio(BaseOptions(baseUrl: newsApiBaseUrl));
  sl.registerSingleton<Dio>(dio);

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  // Providers
  sl.registerFactory<RemoteArticleProvider>(() => RemoteArticleProvider(sl()));
  sl.registerFactory<LocalArticleProvider>(
    () => LocalArticleProvider(sl(), sl(), sl()),
  );
}
