import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';

class VideoLessons extends StatelessWidget {
  final List<VideoLesson> list;

  const VideoLessons({
    super.key = const Key("videolessons"),
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    final width = MediaQuery.of(context).size.width;
    //this calculus is to make both cards occupy the same space in phone screen.
    //in the tablet the size is absolute
    var cardWidth =
        (width - (dimensions.topVideosItemsPerRow + 1) * dimensions.screenMargin) / dimensions.topVideosItemsPerRow;
    var cardHeight = cardWidth * 0.55;
    return SliverPadding(
      padding: EdgeInsets.all(dimensions.screenMargin),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: dimensions.topVideosItemsPerRow,
            crossAxisSpacing: dimensions.screenMargin,
            mainAxisSpacing: dimensions.screenMargin),
        delegate: SliverChildBuilderDelegate(
          childCount: list.length,
          (context, index) {
            return VideoLessonItem(
              videolesson: list[index],
              // coverage:ignore-start
              onTap: () {},
              // coverage:ignore-end
              width: cardWidth,
              height: cardHeight,
            );
          },
        ),
      ),
    );
  }
}
