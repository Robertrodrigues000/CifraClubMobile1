import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genre_header.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class GenresList extends StatelessWidget {
  final List<GenreItem> genres;
  final void Function(Genre) onTap;

  const GenresList({super.key, required this.genres, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final item = genres[index];
        if (item is GenreHeaderItem) {
          return GenreHeader(
            text: item.type.getLocalizedText(context),
            isDividerVisible: index > 0,
          );
        } else if (item is GenreListItem) {
          return IconTextTile(
              onClick: () => onTap(item.genre),
              leadingIconUrl: item.genre.genreImages?.light ?? "",
              leadingIconPlaceholder: AppSvgs.genresInactive,
              text: item.genre.name);
        } else if (item is GenreDivider) {
          return Divider(
            color: CosmosColorScheme.of(context).neutralTertiary,
          );
        }
        return Container();
      },
    );
  }
}
