import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_image_group.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/pick_shape_image.dart';
import 'package:cifraclub/presentation/widgets/rectangle_shape_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTile extends StatelessWidget {
  final VoidCallback onTap;
  final String? imageUrl;
  final List<String>? listPreview;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const SearchTile(
      {super.key,
      required this.onTap,
      this.imageUrl,
      required this.title,
      this.subtitle,
      this.trailing,
      this.listPreview});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final maxWidth = MediaQuery.of(context).size.width;
    return ContainerWithRippleEffect(
      width: maxWidth,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: context.appDimensionScheme.screenMargin),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (listPreview != null)
              ListImageGroup(images: listPreview!)
            else
              RemoteImage(
                imageUrl: imageUrl,
                // coverage:ignore-start
                imageBuilder: (context, imageProvider) => subtitle != null
                    ? RectangleShapeImage(
                        imageProvider: imageProvider,
                      )
                    : PickShapeImage(
                        imageProvider: imageProvider,
                      ),
                // coverage:ignore-end
                placeholder: subtitle != null
                    ? RectangleShapeImage(
                        child: SvgPicture.asset(
                          AppSvgs.artistsAvatarPlaceHolder,
                        ),
                      )
                    : PickShapeImage(
                        child: SvgPicture.asset(
                          AppSvgs.artistsAvatarPlaceHolder,
                        ),
                      ),
              ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: subtitle != null ? MainAxisAlignment.start : MainAxisAlignment.center,
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
