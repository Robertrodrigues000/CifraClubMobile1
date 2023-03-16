import 'package:cifraclub/data/genre/models/genre_images_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cifraclub/domain/genre/models/genre.dart';

part 'genre_dto.g.dart';

@JsonSerializable(createToJson: false)
class GenreDto extends Equatable {
  final String name;
  final String url;
  @JsonKey(name: "icons")
  final GenreImagesDto? genreImages;

  const GenreDto({
    required this.name,
    required this.url,
    this.genreImages,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) => _$GenreDtoFromJson(json);

  Genre toDomain() {
    return Genre(name: name, url: url, genreImages: genreImages?.toDomain());
  }

  @override
  List<Object> get props => [name, url];
}
