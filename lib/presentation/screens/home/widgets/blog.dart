// coverage:ignore-file
import 'package:cifraclub/domain/home/models/news.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({
    super.key = const Key("blog"),
    required this.list,
  });

  final List<News> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: list.isNotEmpty ? list.length + 2 : 0,
        (context, index) {
          if (index == 0) {
            return const Text("Notícias e Novidades");
          } else if (index == list.length + 1) {
            return const Text("Mostrar mais posts do blog");
          } else {
            return Card(
              child: Text(list[index - 1].headline),
            );
          }
        },
      ),
    );
  }
}
