import 'package:cifraclub/domain/genre/models/genre_images.dart';
import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final String name;
  final String url;
  final GenreImages? genreImages;

  const Genre({required this.name, required this.url, this.genreImages});

  @override
  List<Object> get props => [name, url];
}
