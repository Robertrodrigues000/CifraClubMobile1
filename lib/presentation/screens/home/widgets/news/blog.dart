import 'package:cifraclub/domain/home/models/news.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/widgets/news/news_item.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({
    super.key = const Key("blog"),
    required this.list,
    required this.onTap,
  });

  final List<News> list;
  final Function(News) onTap;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: context.appDimensionScheme.screenMargin),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.appDimensionScheme.newsItemsPerRow,
            mainAxisExtent: 80 + 2 * context.appDimensionScheme.newsItemVerticalPadding),
        delegate: SliverChildBuilderDelegate(
          childCount: list.length,
          (context, index) {
            final news = list[index];
            return NewsItem(
              key: Key(news.headline),
              news: news,
              onTap: () => onTap(news),
            );
          },
        ),
      ),
    );
  }
}
