// coverage:ignore-file
import 'package:cifraclub/domain/home/models/video_lessons.dart';
import 'package:flutter/material.dart';

class HomeVideoLessons extends StatelessWidget {
  const HomeVideoLessons({
    super.key = const Key("videolessons"),
    required this.list,
  });

  final List<VideoLessons> list;

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
              child: Text(list[index - 1].title),
            );
          }
        },
      ),
    );
  }
}
