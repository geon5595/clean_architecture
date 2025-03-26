import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/feature/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:newproject/feature/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_provider.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_state.dart';
import 'package:newproject/feature/daily_news/presentation/widgets/article_tile.dart';
import 'package:provider/provider.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  _buildAppBar(BuildContext context) {
    print('buildAppBar');
    return AppBar(
      title: const Text('Daily News'),
      actions: [
        IconButton(
          onPressed:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedArticle()),
              ),
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }

  _buildBody() {
    return Consumer<RemoteArticleProvider>(
      builder: (context, provider, child) {
        final state = provider.state;

        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ArticleDetailsView(
                              article: state.articles![index],
                            ),
                      ),
                    ),
                child: ArticleTile(article: state.articles![index]),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
