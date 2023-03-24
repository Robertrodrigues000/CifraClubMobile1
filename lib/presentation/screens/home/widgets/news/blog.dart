import 'package:cifraclub/domain/home/models/news.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/screens/home/widgets/news/news_item.dart';
import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  const Blog({
    super.key = const Key("blog"),
    required this.list,
    required this.onTap,
  });

  final List<News> list;
  final Function(News) onTap;

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  late double textHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textHeight = 2 * context.typography.subtitle2.getTextSize(context: context).height +
        context.typography.subtitle5.getTextSize(context: context).height;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: context.appDimensionScheme.screenMargin),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.appDimensionScheme.newsItemsPerRow,
            mainAxisExtent: textHeight + 2 * context.appDimensionScheme.newsItemTextPadding + 4),
        delegate: SliverChildBuilderDelegate(
          childCount: widget.list.length,
          (context, index) {
            final news = widget.list[index];
            return NewsItem(
              key: Key(news.headline),
              news: news,
              onTap: () => widget.onTap(news),
            );
          },
        ),
      ),
    );
  }
}
