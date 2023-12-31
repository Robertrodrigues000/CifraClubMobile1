import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/pick_shape_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String ranking;
  final String? imageUrl;
  final Widget? trailing;
  final VoidCallback onTap;

  const TopListItem(
      {super.key,
      required this.title,
      this.subtitle,
      required this.ranking,
      this.imageUrl,
      this.trailing,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _TopListItemContent(
        title: title,
        subtitle: subtitle,
        ranking: ranking,
        imageUrl: imageUrl,
        onTap: onTap,
        trailing: trailing,
        padding: context.appDimensionScheme.screenMargin,
        rankWidth: context.appDimensionScheme.topCellRankingWidth);
  }
}

class _TopListItemContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String ranking;
  final String? imageUrl;
  final Widget? trailing;
  final VoidCallback onTap;
  final double padding;
  final double rankWidth;

  const _TopListItemContent(
      {required this.title,
      required this.subtitle,
      required this.ranking,
      required this.imageUrl,
      this.trailing,
      required this.onTap,
      required this.padding,
      required this.rankWidth});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final maxWidth = MediaQuery.of(context).size.width;
    return ContainerWithRippleEffect(
      width: maxWidth,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: subtitle != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            RemoteImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => PickShapeImage(
                imageProvider: imageProvider,
                fixedSize: 40,
              ),
              placeholder: PickShapeImage(
                key: const Key("avatarPlaceHolder"),
                fixedSize: 40,
                child: SvgPicture.asset(
                  AppSvgs.artistsAvatarPlaceHolder,
                ),
              ),
            ),
            SizedBox(
              width: rankWidth,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  ranking,
                  style: typography.subtitle3.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(children: [
                    Flexible(
                      child: Text(
                        title,
                        style: typography.subtitle3,
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (trailing != null) trailing!,
                  ]),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: typography.subtitle5,
                      overflow: TextOverflow.ellipsis,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
