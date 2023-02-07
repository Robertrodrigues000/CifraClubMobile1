import 'package:cifraclub/data/artist/models/artist_image_dto.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistDto extends Equatable {
  final int id;
  final String name;
  final String url;
  final GenreDto? genre;
  final ArtistImageDto? image;

  const ArtistDto({required this.url, this.genre, required this.image, required this.name, required this.id});

  factory ArtistDto.fromJson(Map<String, dynamic> json) => _$ArtistDtoFromJson(json);

  Artist toDomain() {
    return Artist(url: url, genre: genre?.toDomain(), image: image?.toDomain(), name: name, id: id);
  }

  // coverage:ignore-start
  @override
  List<Object> get props => [id, name];
  // coverage:ignore-end
}
