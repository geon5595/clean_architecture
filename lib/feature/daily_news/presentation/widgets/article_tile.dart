import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/feature/daily_news/domain/entities/article.dart';

class ArticleTile extends StatelessWidget {
  final ArticleEntity? article;
  const ArticleTile({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: Row(children: [_buildImage(context), _buildTitleAndDescription()]),
    );
  }

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article?.urlToImage ?? '',
      imageBuilder:
          (context, imageProvider) => Padding(
            padding: EdgeInsets.only(right: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
      progressIndicatorBuilder:
          (context, url, downloadProgress) => Padding(
            padding: EdgeInsets.only(right: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 160,
                child: const CupertinoActivityIndicator(),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
            ),
          ),
      errorWidget:
          (context, url, error) => Padding(
            padding: EdgeInsets.only(right: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
                child: const Icon(Icons.error),
              ),
            ),
          ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article?.title ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(article?.description ?? '', maxLines: 2),
            ),
            Row(
              children: [
                Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article?.publishedAt ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
