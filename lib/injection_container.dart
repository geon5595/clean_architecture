import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:newproject/core/constants/constant.dart';
import 'package:newproject/feature/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:newproject/feature/daily_news/data/repository/article_repository_impl.dart';
import 'package:newproject/feature/daily_news/domain/repository/article_repository.dart';
import 'package:newproject/feature/daily_news/domain/usecases/get_article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  final dio = Dio(BaseOptions(baseUrl: newsApiBaseUrl));

  sl.registerSingleton<Dio>(dio);

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  // UseCases
  sl.registerCachedFactory<GetArticleUseCase>(() => GetArticleUseCase(sl()));

  // Providers
  sl.registerFactory<RemoteArticleProvider>(() => RemoteArticleProvider(sl()));
}
