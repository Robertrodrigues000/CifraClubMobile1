import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoLessonItem extends StatelessWidget {
  final VideoLesson videolesson;
  final double width;
  final double height;
  final VoidCallback onTap;
  const VideoLessonItem({
    super.key,
    required this.videolesson,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final styles = context.typography;
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onTap,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            RemoteImage(
              // coverage:ignore-start
              imageUrl: videolesson.images.medium,
              imageBuilder: (context, imageProvider) {
                return Ink(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              // coverage:ignore-end
              placeholder: Ink(
                padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: CosmosColors.grey90,
                ),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CosmosColors.white,
                    ),
                    child: Center(
                      child: SvgPicture.asset(AppSvgs.videoPlaceholder),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                color: CosmosColorScheme.of(context).neutralPrimary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      videolesson.title,
                      style: styles.subtitle4,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    if (videolesson.artist != null)
                      Text(
                        key: const Key("videolesson artist name"),
                        videolesson.artist!.name,
                        style: styles.subtitle4.copyWith(
                          color: CosmosColorScheme.of(context).primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
