import 'package:cifraclub/domain/genre/entities/genre.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class GenresList extends StatelessWidget {
  const GenresList({
    super.key,
    required this.genres,
  });

  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return Center(
        child: Text(context.text.emptyList),
      );
    } else {
      return ListView.builder(
          itemCount: genres.length,
          itemBuilder: (context, index) {
            var genre = genres[index];
            return ListTile(
              title: Text(genre.name),
              trailing: Text(genre.url),
            );
          });
    }
  }
}
