import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArtistSongItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onOptionsTap;
  final String name;
  final int ranking;
  final bool isVerified;
  final bool hasVideoLessons;

  const ArtistSongItem({
    super.key,
    required this.onTap,
    required this.onOptionsTap,
    required this.name,
    required this.ranking,
    required this.isVerified,
    required this.hasVideoLessons,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: context.appDimensionScheme.screenMargin),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: hasVideoLessons ? CrossAxisAlignment.baseline : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              width: 28,
              child: Text(
                ranking.toString(),
                style: context.typography.subtitle3.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          style: context.typography.subtitle3,
                          overflow: TextOverflow.ellipsis,
                          textWidthBasis: TextWidthBasis.longestLine,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (isVerified) SvgPicture.asset(AppSvgs.verifiedIcon)
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  if (hasVideoLessons)
                    Row(
                      children: [
                        SvgPicture.asset(AppSvgs.videoLessonIcon),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          context.text.videoLesson,
                          style: context.typography.subtitle5,
                        )
                      ],
                    )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: onOptionsTap,
                splashRadius: 28,
                padding: const EdgeInsets.all(12),
                highlightColor: Theme.of(context).splashColor,
                icon: SvgImage(
                  assetPath: AppSvgs.songbookOptionsIcon,
                  color: context.colors.textPrimary,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
