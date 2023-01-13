// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistDto _$ArtistDtoFromJson(Map<String, dynamic> json) => ArtistDto(
      url: json['url'] as String,
      genre: GenreDto.fromJson(json['genre'] as Map<String, dynamic>),
      image: json['image'] == null ? null : ArtistImageDto.fromJson(json['image'] as Map<String, dynamic>),
      name: json['name'] as String,
      id: json['id'] as int,
    );
