// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreDto _$GenreDtoFromJson(Map<String, dynamic> json) => GenreDto(
      name: json['name'] as String,
      url: json['url'] as String,
      genreImages: json['icons'] == null ? null : GenreImagesDto.fromJson(json['icons'] as Map<String, dynamic>),
    );
