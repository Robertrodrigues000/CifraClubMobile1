import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';

class YouTubeVideoItem extends StatelessWidget {
  final int duration;
  final String imageUrl;
  final String videoName;
  final String views;
  final VoidCallback onTap;

  const YouTubeVideoItem({
    super.key,
    required this.duration,
    required this.imageUrl,
    required this.videoName,
    required this.views,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.neutralPrimary,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 92,
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Row(
            children: [
              VideoCard(
                duration: duration,
                imageUrl: imageUrl,
              ),
              SizedBox.fromSize(size: const Size.fromWidth(16)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      videoName,
                      style: context.typography.subtitle3,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox.fromSize(size: const Size.fromHeight(2)),
                    Text(
                      views,
                      style: context.typography.subtitle5,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
