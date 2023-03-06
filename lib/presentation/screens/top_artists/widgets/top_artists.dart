import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:flutter/material.dart';

class TopArtists extends StatelessWidget {
  final List<Artist> topArtists;
  final String selectedGenre;
  final Function(Artist) onTap;
  const TopArtists({
    super.key,
    required this.topArtists,
    required this.onTap,
    required this.selectedGenre,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: topArtists.length + 1,
        (context, index) {
          if (index >= topArtists.length) {
            return Container(
              height: context.appDimensionScheme.scrollContentToBottom,
            );
          }
          final artist = topArtists[index];
          return TopListItem(
            key: Key(artist.name),
            onTap: () => onTap(artist),
            title: artist.name,
            imageUrl: artist.image?.size162,
            subtitle: selectedGenre == "todos" ? artist.genre?.name : null, //TODO : adiconar capsula de todos
            ranking: (index + 1).toString(),
          );
        },
      ),
    );
  }
}
