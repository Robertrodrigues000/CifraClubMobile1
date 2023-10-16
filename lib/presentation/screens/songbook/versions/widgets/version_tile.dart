import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class VersionTile extends StatelessWidget {
  const VersionTile(
      {Key? key,
      required this.song,
      required this.artist,
      required this.type,
      required this.versionKey,
      this.editable = false,
      this.onOptionsTap,
      this.onVersionTap,
      this.onDeleteTap,
      this.index})
      : super(key: key);
  final String song;
  final String artist;
  final String type;
  final String? versionKey;
  final bool editable;
  final VoidCallback? onOptionsTap;
  final VoidCallback? onVersionTap;
  final VoidCallback? onDeleteTap;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onVersionTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (editable) ...[
              Padding(
                padding: EdgeInsets.only(left: context.appDimensionScheme.iconTileSpace, right: 4),
                child: IconButton(
                  onPressed: onDeleteTap,
                  padding: const EdgeInsets.all(12),
                  highlightColor: Theme.of(context).splashColor,
                  icon: Icon(
                    Icons.remove_circle,
                    color: context.colors.errorTertiary,
                  ),
                ),
              ),
            ] else
              SizedBox(
                width: context.appDimensionScheme.internalMargin,
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    song,
                    style: context.typography.subtitle3,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    artist,
                    style: context.typography.subtitle5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        type,
                        style: context.typography.subtitle5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (versionKey != null)
                        Text(
                          context.text.versionKey(versionKey!),
                          style: context.typography.subtitle5,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                    ],
                  )
                ],
              ),
            ),
            if (onVersionTap != null)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: context.appDimensionScheme.iconTileSpace),
                  child: editable
                      ? ReorderableDragStartListener(
                          index: index ?? 0,
                          child: IconButton(
                            // coverage:ignore-start
                            onPressed: () {},
                            // coverage:ignore-end
                            padding: const EdgeInsets.all(12),
                            highlightColor: Theme.of(context).splashColor,
                            icon: SvgImage(
                              assetPath: AppSvgs.dragIcon,
                              color: context.colors.textPrimary,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        )
                      : IconButton(
                          key: const Key("options-button"),
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
          ],
        ),
      ),
    );
  }
}
