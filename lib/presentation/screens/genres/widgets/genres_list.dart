import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genre_header.dart';
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
          return GenreHeader(text: item.type.getLocalizedText(context));
        } else if (item is GenreListItem) {
          return ListTile(
            onTap: () => onTap(item.genre),
            title: Text(item.genre.name),
          );
        }
        return Container();
      },
    );
  }
}
