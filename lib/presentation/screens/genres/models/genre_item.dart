import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';

abstract class GenreItem extends Equatable {
  const GenreItem();
}

class GenreHeaderItem extends GenreItem {
  final GenreHeaderType type;
  const GenreHeaderItem({required this.type});

  @override
  List<Object?> get props => [type];
}

class GenreListItem extends GenreItem {
  final Genre genre;

  const GenreListItem({required this.genre});

  @override
  List<Object?> get props => [genre];
}

class GenreDivider extends GenreItem {
  @override
  List<Object?> get props => [];
}

enum GenreHeaderType {
  top,
  all,
  musicalStyles;

  String getLocalizedText(BuildContext context) {
    switch (this) {
      case top:
        return context.text.genreHeaderTops; // TODO: revisar textos
      case all:
        return context.text.genreHeaderAll; // TODO: revisar textos
      case musicalStyles:
        return context.text.musicalStyles;
    }
  }
}
