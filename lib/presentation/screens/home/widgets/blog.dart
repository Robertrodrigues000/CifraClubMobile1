import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({super.key, required this.list});

  final List<int> list;

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
              child: Text("${list[index - 1]}"),
            );
          }
        },
      ),
    );
  }
}
