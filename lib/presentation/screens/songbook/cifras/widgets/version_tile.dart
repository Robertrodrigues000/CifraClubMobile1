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
      required this.tone,
      this.editable = false,
      required this.onOptionsTap,
      required this.onVersionTap,
      required this.onDeleteTap,
      required this.onDragTap})
      : super(key: key);
  final String song;
  final String artist;
  final String type;
  final String tone;
  final bool editable;
  final VoidCallback onOptionsTap;
  final VoidCallback onVersionTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onDragTap;

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
              IconButton(
                onPressed: onDeleteTap,
                padding: const EdgeInsets.all(12),
                highlightColor: Theme.of(context).splashColor,
                icon: Icon(
                  Icons.remove_circle,
                  color: context.colors.errorTertiary,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
            ] else ...[
              const SizedBox(
                width: 16,
              ),
            ],
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
                      Text(
                        context.text.tabTone(tone),
                        style: context.typography.subtitle5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                  onPressed: onDragTap,
                  padding: const EdgeInsets.all(12),
                  highlightColor: Theme.of(context).splashColor,
                  icon: SvgImage(
                    assetPath: editable ? AppSvgs.dragIcon : AppSvgs.songbookOptionsIcon,
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
