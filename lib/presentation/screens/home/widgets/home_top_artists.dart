import 'package:flutter/material.dart';

class HomeTopArtists extends StatelessWidget {
  const HomeTopArtists({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: list.isNotEmpty ? list.length + 2 : 0,
        (context, index) {
          if (index == 0) {
            return const Text("Top Artistas");
          } else if (index == list.length + 1) {
            return const Text("Mais artistas");
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