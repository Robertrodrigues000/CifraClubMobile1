import 'dart:core';

import 'package:cifraclub/data/artist/models/artist_image_dto.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artist_info_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistInfoDto {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "url")
  final String url;

  @JsonKey(name: "hits")
  final int hitsCount;

  @JsonKey(name: "genre")
  final GenreDto genre;

  @JsonKey(name: "image")
  final ArtistImageDto? imagesDto;

  @JsonKey(name: "headImage")
  final ArtistImageDto? headImageDto;

  const ArtistInfoDto({
    required this.id,
    required this.name,
    required this.url,
    required this.hitsCount,
    required this.genre,
    this.imagesDto,
    this.headImageDto,
  });

  factory ArtistInfoDto.fromJson(Map<String, dynamic> json) => _$ArtistInfoDtoFromJson(json);

  ArtistInfo toDomain() => ArtistInfo(
        id: id,
        name: name,
        url: url,
        hitsCount: hitsCount,
        genre: genre.toDomain(),
        imagesDto: imagesDto?.toDomain(),
        headImageDto: headImageDto?.toDomain(),
      );
}
