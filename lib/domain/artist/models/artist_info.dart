import 'dart:core';

import 'package:cifraclub/domain/artist/models/artist_head_image.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:equatable/equatable.dart';

class ArtistInfo extends Equatable {
  final int id;
  final String name;
  final String url;
  final int hitsCount;
  final Genre genre;
  final ArtistImage? imagesDto;
  final ArtistHeadImage? headImageDto;

  const ArtistInfo({
    required this.id,
    required this.name,
    required this.url,
    required this.hitsCount,
    required this.genre,
    this.imagesDto,
    this.headImageDto,
  });

  @override
  List<Object?> get props => [id, name, url, hitsCount, genre, imagesDto, headImageDto];
}
