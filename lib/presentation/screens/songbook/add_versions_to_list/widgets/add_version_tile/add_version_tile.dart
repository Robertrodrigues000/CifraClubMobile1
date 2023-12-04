import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_selection_state.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddVersionTile extends StatelessWidget {
  final VoidCallback onTap;
  final String? imageUrl;
  final String song;
  final String? artist;
  final SongSelectionState state;
  final Widget? trailing;

  const AddVersionTile({
    super.key,
    required this.onTap,
    this.imageUrl,
    required this.song,
    this.artist,
    required this.state,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final maxWidth = MediaQuery.of(context).size.width;
    return ContainerWithRippleEffect(
      width: maxWidth,
      onTap: state == SongSelectionState.added ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: context.appDimensionScheme.screenMargin),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: state == SongSelectionState.added ? 0.4 : 1,
              child: RemoteImage(
                imageUrl: imageUrl,
                // coverage:ignore-start
                imageBuilder: (context, imageProvider) => Container(
                  width: context.appDimensionScheme.addVersionTileImageSize,
                  height: context.appDimensionScheme.addVersionTileImageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                // coverage:ignore-end
                placeholder: Container(
                  key: const Key("avatarPlaceHolder"),
                  clipBehavior: Clip.hardEdge,
                  height: context.appDimensionScheme.addVersionTileImageSize,
                  width: context.appDimensionScheme.addVersionTileImageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(
                    AppSvgs.artistsAvatarPlaceHolder,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Opacity(
                opacity: state == SongSelectionState.added ? 0.5 : 1,
                child: Column(
                  mainAxisAlignment: artist != null ? MainAxisAlignment.start : MainAxisAlignment.center,
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(children: [
                      Flexible(
                        child: Text(
                          song,
                          style: typography.subtitle3,
                          overflow: TextOverflow.ellipsis,
                          textWidthBasis: TextWidthBasis.longestLine,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (trailing != null) trailing!,
                    ]),
                    if (artist != null)
                      Text(
                        artist!,
                        style: typography.subtitle5,
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(width: context.appDimensionScheme.screenMargin),
            if (state.icon != null)
              SvgImage(
                assetPath: state.icon,
                color: state == SongSelectionState.toAdd ? context.colors.textPrimary : null,
              )
            else ...[Text(context.text.onList, style: typography.subtitle5)],
          ],
        ),
      ),
    );
  }
}
