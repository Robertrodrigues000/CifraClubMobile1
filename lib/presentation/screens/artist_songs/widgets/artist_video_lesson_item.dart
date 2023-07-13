import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/default_placeholder.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter/material.dart';

class ArtistVideoLessonItem extends StatelessWidget {
  final String imageUrl;
  final String artistName;
  final String title;
  final String views;
  final String duration;
  final String versionLabel;
  final VoidCallback onTap;
  const ArtistVideoLessonItem({
    super.key,
    required this.imageUrl,
    required this.artistName,
    required this.title,
    required this.views,
    required this.duration,
    required this.versionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: context.appDimensionScheme.screenMargin),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
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
                    duration,
                    style: context.typography.subtitle7.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artistName,
                    style: context.typography.subtitle4.copyWith(color: context.colors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    title,
                    style: context.typography.subtitle4,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "$views ${context.text.views} • $versionLabel",
                    style: context.typography.subtitle7,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
