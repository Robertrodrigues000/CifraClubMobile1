import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/default_placeholder.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VideoCard extends StatelessWidget {
  final String imageUrl;
  final int duration;

  const VideoCard({
    super.key,
    required this.imageUrl,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // coverage:ignore-start
        RemoteImage(
          imageUrl: imageUrl,
          imageBuilder: (image, imageProvider) => Container(
            width: 100,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // coverage:ignore-end
          placeholder: const DefaultPlaceholder(
            height: 56,
            width: 100,
            svgIcon: AppSvgs.videoPlaceholder,
            isLarge: true,
          ),
        ),
        Container(
          width: 40,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.scrimOverlay,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Text(
            formatVideoLessonDuration(duration),
            style: context.typography.subtitle7.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  String formatVideoLessonDuration(int seconds) {
    return DateFormat.ms().format(DateTime.fromMillisecondsSinceEpoch(Duration(seconds: seconds).inMilliseconds));
  }
}
