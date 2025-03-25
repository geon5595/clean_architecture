import 'package:flutter/material.dart';
import 'package:newproject/feature/daily_news/domain/entities/article.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_event.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/local/local_article_provider.dart';
import 'package:newproject/feature/daily_news/presentation/provider/article/remote/remote_article_provider.dart';
import 'package:provider/provider.dart';

class ArticleDetailsView extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleDetailsView({this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<RemoteArticleProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
          floatingActionButton: _buildFloatingActionButton(context),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder:
            (context) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _onBackButtonTapped(context),
              child: const Icon(Icons.chevron_left, color: Colors.black),
            ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(article?.title ?? ''),
          const SizedBox(height: 14),
          // datetime
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: 16),
              const SizedBox(width: 4),
              Text(article?.publishedAt ?? '', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: 120,
      height: 250,
      margin: EdgeInsets.only(top: 14),
      child: Image.network(article?.urlToImage ?? '', fit: BoxFit.cover),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Text(
        '${article?.description ?? ''}\n\n${article?.content ?? ''}',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onFloatingActionButtonTapped(context),
      child: const Icon(Icons.save, color: Colors.white),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonTapped(BuildContext context) {
    final provider = Provider.of<LocalArticleProvider>(context, listen: false);
    provider.onSaveArticle(SaveArticle(article!));
  }
}
