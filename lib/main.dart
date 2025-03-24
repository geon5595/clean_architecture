import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newproject/injection_container.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_provider.dart';
import 'package:newproject/feature/daily_news/presentation/pages/daily_news.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<RemoteArticleProvider>(),
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const DailyNews(),
      ),
    );
  }
}
