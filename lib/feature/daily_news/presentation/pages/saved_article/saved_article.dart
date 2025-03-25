import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/feature/daily_news/domain/entities/article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_provider.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_state.dart';
import 'package:newproject/feature/daily_news/presentation/widgets/article_tile.dart';
import 'package:provider/provider.dart';

class SavedArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalArticleProvider>(
      builder: (context, provider, child) {
        return Scaffold(appBar: _buildAppBar(), body: _buildBody());
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder:
            (context) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
      ),
      title: const Text('Saved Articles'),
    );
  }

  Widget _buildBody() {
    return Consumer<LocalArticleProvider>(
      builder: (context, provider, child) {
        if (provider.state is LocalArticlesDone) {
          return _buildArticlesList(provider.state.articles!);
        } else if (provider.state is LocalArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(child: Text('No saved articles'));
    }

    return ListView.builder(
      itemBuilder: (context, index) => ArticleTile(article: articles[index]),
      itemCount: articles.length,
    );
  }
}
