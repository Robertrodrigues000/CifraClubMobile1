// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_lessons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoLessonsDto _$VideoLessonsDtoFromJson(Map<String, dynamic> json) => VideoLessonsDto(
      id: json['id'] as int,
      youtubeId: json['youtubeId'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
      views: json['views'] as int,
      duration: json['duration'] as int,
      urlApi: json['urlApi'] as String,
      instruments: (json['instruments'] as List<dynamic>?)?.map((e) => e as String).toList(),
      song: json['song'] == null ? null : SongDto.fromJson(json['song'] as Map<String, dynamic>),
      artist: json['artist'] == null ? null : ArtistDto.fromJson(json['artist'] as Map<String, dynamic>),
      images: json['images'] == null ? null : VideoLessonsImageDto.fromJson(json['images'] as Map<String, dynamic>),
    );
