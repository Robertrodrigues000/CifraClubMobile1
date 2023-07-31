import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArtistSongItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onOptionsTap;
  final String name;
  final String prefix;
  final bool isVerified;
  final bool hasVideoLessons;
  final bool isEnable;

  const ArtistSongItem(
      {super.key,
      required this.onTap,
      required this.onOptionsTap,
      required this.name,
      required this.prefix,
      required this.isVerified,
      required this.hasVideoLessons,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      child: SizedBox(
        height: 72,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: hasVideoLessons ? CrossAxisAlignment.baseline : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Padding(
              padding: EdgeInsets.only(left: context.appDimensionScheme.screenMargin, right: 12),
              child: SizedBox(
                width: 28,
                child: Text(
                  prefix,
                  style: context.typography.subtitle3.copyWith(
                    color: context.colors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                          name.replaceAll("&amp;", "&"),
                          style: isEnable
                              ? context.typography.subtitle3
                              : context.typography.subtitle3.copyWith(color: context.colors.disabled),
                          overflow: TextOverflow.ellipsis,
                          textWidthBasis: TextWidthBasis.longestLine,
                        ),
                      ),
                      if (isVerified) ...[
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(AppSvgs.verifiedIcon),
                      ]
                    ],
                  ),
                  if (hasVideoLessons) ...[
                    const SizedBox(
                      height: 2,
                    ),
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
                  ]
                ],
              ),
            ),
            if (isEnable) ...[
              const SizedBox(
                width: 4,
              ),
              Padding(
                padding: EdgeInsets.only(right: context.appDimensionScheme.artistSongItemRightMargin),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onOptionsTap,
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
              ),
            ]
          ],
        ),
      ),
    );
  }
}
