// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_data_song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDataSongDto _$VersionDataSongDtoFromJson(Map<String, dynamic> json) => VersionDataSongDto(
      id: json['id'] as int,
      label: json['label'] as String,
      hits: json['hits'] as int,
      versionUrl: json['versionUrl'] as String,
      instrumentUrl: json['instrumentUrl'] as String,
      videoLesson: json['videoLesson'] == null
          ? null
          : VersionDataVideoLessonDto.fromJson(json['videoLesson'] as Map<String, dynamic>),
      level: json['level'] as int,
      url: json['url'] as String,
      verified: json['verified'] as bool,
    );
