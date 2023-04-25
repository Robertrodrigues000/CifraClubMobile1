import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/string.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoLessonItem extends StatefulWidget {
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
  State<VideoLessonItem> createState() => _VideoLessonItemState();
}

class _VideoLessonItemState extends State<VideoLessonItem> with SingleTickerProviderStateMixin {
  bool isPressing = false;
  final animationDurationMs = const Duration(milliseconds: 200);
  late final AnimationController fadeAnimationController = AnimationController(
    vsync: this,
    duration: animationDurationMs,
    upperBound: 0.2,
  );
  late final Animation<double> fadeAnimation = CurvedAnimation(
    parent: fadeAnimationController,
    curve: Curves.linear,
    reverseCurve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    fadeAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed && !isPressing) {
          fadeAnimationController.reverse();
        }
      },
    );
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = context.typography;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        isPressing = true;
        fadeAnimationController.forward();
      },
      onTapUp: (details) {
        isPressing = false;
        if (fadeAnimationController.isCompleted) {
          fadeAnimationController.reverse();
        } else {
          fadeAnimationController.value = 1;
        }
        widget.onTap();
      },
      onTapCancel: () {
        isPressing = false;
        if (fadeAnimationController.isCompleted) {
          fadeAnimationController.reverse();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AnimatedBuilder(
            animation: fadeAnimation,
            builder: (context, child) {
              return ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (rect) => LinearGradient(
                  colors: [
                    CosmosColors.white.withOpacity(fadeAnimation.value),
                    CosmosColors.white.withOpacity(fadeAnimation.value),
                  ],
                ).createShader(rect),
                child: child,
              );
            },
            child: RemoteImage(
              // coverage:ignore-start
              imageUrl: widget.videolesson.images.medium,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: widget.width,
                  height: widget.height,
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
              placeholder: Container(
                padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: CosmosColors.grey90,
                ),
                child: Center(
                  child: Center(
                    child: SvgPicture.asset(AppSvgs.videoPlaceholder),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              color: context.colors.neutralPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    widget.videolesson.title,
                    style: styles.subtitle4,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  if (widget.videolesson.artist != null)
                    Text(
                      key: const Key("videolesson artist name"),
                      widget.videolesson.artist!.name,
                      style: styles.subtitle4.copyWith(
                        color: context.colors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 2),
                  Text(
                    widget.videolesson.version?.label.formatString() ?? "",
                    style: styles.subtitle5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
