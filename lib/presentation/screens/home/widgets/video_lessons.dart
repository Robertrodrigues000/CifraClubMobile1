import 'package:flutter/material.dart';

class VideoLessons extends StatelessWidget {
  const VideoLessons({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: list.isNotEmpty ? list.length + 1 : 0,
        (context, index) {
          if (index == 0) {
            return const Text("Videos");
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
