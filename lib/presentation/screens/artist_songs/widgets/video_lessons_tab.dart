import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class VideoLessonsTab extends StatelessWidget {
  const VideoLessonsTab(
      {super.key,
      this.videoLessonsError,
      required this.onTapReload,
      required this.isLoading,
      required this.videoLessons,
      required this.videoLessonsFilteredBySearch,
      required this.onTapVideoLesson});
  final RequestError? videoLessonsError;
  final VoidCallback onTapReload;
  final bool isLoading;
  final List<VideoLesson> videoLessons;
  final List<VideoLesson> videoLessonsFilteredBySearch;
  final Function(VideoLesson) onTapVideoLesson;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        return CustomScrollView(slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          if (videoLessonsError != null)
            SliverFillRemaining(
              child: Center(
                child: SingleChildScrollView(
                  child: ErrorDescriptionWidget(
                    typeError: videoLessonsError! is ConnectionError
                        ? ErrorDescriptionWidgetType.connection
                        : ErrorDescriptionWidgetType.server,
                    onClick: onTapReload,
                  ),
                ),
              ),
            )
          else if (isLoading)
            const SliverFillRemaining(child: Center(child: LoadingIndicator())) // coverage:ignore-line
          else if (videoLessons.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: SingleChildScrollView(
                  child: ErrorDescriptionWidget(
                    typeError: ErrorDescriptionWidgetType.videoLesson,
                  ),
                ),
              ),
            )
          else if (videoLessonsFilteredBySearch.isEmpty)
            SliverPadding(
              padding: EdgeInsets.only(top: context.appDimensionScheme.artistSongsHeaderSpace),
              sliver: const SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: ErrorDescriptionWidget(
                    typeError: ErrorDescriptionWidgetType.resultNotFound,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: videoLessonsFilteredBySearch.length,
                (context, index) {
                  final videoLesson = videoLessonsFilteredBySearch[index];
                  return ArtistVideoLessonItem(
                    onTap: () => onTapVideoLesson(videoLesson),
                    imageUrl: videoLesson.images.small,
                    artistName: videoLesson.artist?.name ?? "",
                    title: videoLesson.title,
                    views: videoLesson.views,
                    duration: videoLesson.duration,
                    versionLabel: videoLesson.version?.label ?? "",
                  );
                },
              ),
            ),
        ]);
      }),
    );
  }
}
