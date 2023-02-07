// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final int id;
  final String name;
  final String url;
  final Genre? genre;
  final ArtistImage? image;

  const Artist({required this.url, this.genre, required this.image, required this.name, required this.id});

  @override
  List<Object?> get props => [id, name, url, genre, image];
}
