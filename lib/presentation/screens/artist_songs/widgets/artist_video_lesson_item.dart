import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArtistVideoLessonItem extends StatelessWidget {
  final String imageUrl;
  final String artistName;
  final String title;
  final int views;
  final int duration;
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
            VideoCard(imageUrl: imageUrl, duration: duration),
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
                    "${formatVideoLessonView(views, context)} ${context.text.views} • $versionLabel",
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

  String formatVideoLessonView(int views, BuildContext context) {
    return NumberFormat.compact(locale: Localizations.localeOf(context).toLanguageTag()).format(views);
  }
}
