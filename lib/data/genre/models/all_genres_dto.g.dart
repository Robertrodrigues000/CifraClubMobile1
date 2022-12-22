// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_genres_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllGenresDto _$AllGenresDtoFromJson(Map<String, dynamic> json) => AllGenresDto(
      top: (json['top'] as List<dynamic>).map((e) => GenreDto.fromJson(e as Map<String, dynamic>)).toList(),
      all: (json['all'] as List<dynamic>).map((e) => GenreDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
