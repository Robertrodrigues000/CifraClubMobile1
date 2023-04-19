import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lesson_item.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';

class VideoLessons extends StatefulWidget {
  final List<VideoLesson> list;

  const VideoLessons({
    super.key = const Key("videolessons"),
    required this.list,
  });

  @override
  State<VideoLessons> createState() => _VideoLessonsState();
}

class _VideoLessonsState extends State<VideoLessons> {
  late double textHeight;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textHeight = context.typography.subtitle4.getTextSize(context: context).height * 4;
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    final width = MediaQuery.of(context).size.width;
    //this calculus is to make both cards occupy the same space in phone screen.
    //in the tablet the size is absolute
    final imageWidth =
        (width - (dimensions.topVideosItemsPerRow + 1) * dimensions.screenMargin) / dimensions.topVideosItemsPerRow;
    final imageHeight = imageWidth * 0.55;

    return SliverPadding(
      padding: EdgeInsets.all(dimensions.screenMargin),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: dimensions.topVideosItemsPerRow,
          crossAxisSpacing: dimensions.screenMargin,
          mainAxisSpacing: dimensions.screenMargin,
          mainAxisExtent: textHeight + imageHeight + 14,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: widget.list.length,
          (context, index) {
            return VideoLessonItem(
              videolesson: widget.list[index],
              // coverage:ignore-start
              onTap: () {},
              // coverage:ignore-end
              width: imageWidth,
              height: imageHeight,
            );
          },
        ),
      ),
    );
  }
}
