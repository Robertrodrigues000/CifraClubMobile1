import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/pick_shaped_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
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
    final typography = CosmosTypography.of(context);
    final maxWidth = MediaQuery.of(context).size.width;
    return ContainerWithRippleEffect(
      width: maxWidth,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            RemoteImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => PickShapeImage(
                imageProvider: imageProvider,
              ),
              placeholder: PickShapeImage(
                key: const Key("avatarPlaceHolder"),
                child: SvgPicture.asset(
                  AppSvgs.artistsAvatarPlaceHolder,
                ),
              ),
            ),
            SizedBox(
              width: rankWidth,
              child: Center(
                child: Text(
                  ranking,
                  style: typography.subtitle3.copyWith(
                    color: CosmosColorScheme.of(context).textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
