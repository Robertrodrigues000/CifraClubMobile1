import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_image_group.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({
    super.key,
    required this.onTap,
    required this.songbook,
    required this.onOptionsTap,
    required this.isSelected,
  });

  final Songbook songbook;
  final VoidCallback onTap;
  final VoidCallback onOptionsTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final subtitle = getSubtitle(songbook);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: isSelected ? BoxDecoration(color: context.colors.neutralSecondary) : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (isSelected)
              VerticalDivider(
                width: 0,
                thickness: 4,
                color: CosmosColorScheme.of(context).primary,
              ),
            SizedBox(
              width: context.appDimensionScheme.screenMargin,
            ),
            // coverage:ignore-start
            ListImageGroup(
              images: List.generate(
                  songbook.totalSongs,
                  (index) =>
                      "https://akamai.sscdn.co/letras/250x250/fotos/8/d/f/c/8dfc6f49453dc5f678ae7d633f0eb4da.jpg"),
            ),
            // coverage:ignore-end
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.ideographic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    songbook.name,
                    style: context.typography.subtitle3,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    subtitle.isNotEmpty ? subtitle : context.text.emptyList,
                    key: const Key("Cifra Preview Subtitle"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.subtitle5,
                  ),
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
            SizedBox(
              width: context.appDimensionScheme.rightPaddingCard,
            ),
          ],
        ),
      ),
    );
  }

  // coverage:ignore-start
  String getSubtitle(Songbook songbook) {
    final songNames = ["Oops I Did It Again", "Conquista", "Tempo Perdido", "Cupid"];
    songNames.shuffle();
    if (songbook.totalSongs == 0) {
      return "";
    }
    return songNames.take(songbook.totalSongs >= 4 ? 4 : songbook.totalSongs).join(', ');
  }
  // coverage:ignore-end
}
