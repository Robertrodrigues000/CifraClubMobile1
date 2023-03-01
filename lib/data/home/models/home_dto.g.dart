// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDto _$HomeDtoFromJson(Map<String, dynamic> json) => HomeDto(
      highlights:
          json['highlights'] == null ? null : HighlightsDto.fromJson(json['highlights'] as Map<String, dynamic>),
      songs: (json['songs'] as List<dynamic>?)?.map((e) => SongDto.fromJson(e as Map<String, dynamic>)).toList(),
      artists: (json['artists'] as List<dynamic>?)?.map((e) => ArtistDto.fromJson(e as Map<String, dynamic>)).toList(),
      videoLessons: (json['videoLessons'] as List<dynamic>?)
          ?.map((e) => VideoLessonsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      news: (json['news'] as List<dynamic>?)?.map((e) => NewsDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
