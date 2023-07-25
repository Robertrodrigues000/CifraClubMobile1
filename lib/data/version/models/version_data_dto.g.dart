// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDataDto _$VersionDataDtoFromJson(Map<String, dynamic> json) => VersionDataDto(
      id: json['id'] as int,
      type: json['type'] as int,
      status: json['status'] as int,
      content: json['content'] as String,
      label: json['label'] as String,
      versionUrl: json['versionUrl'] as String,
      instrumentUrl: json['instrumentUrl'] as String,
      hits: json['hits'] as int,
      url: json['url'] as String,
      siteUrl: json['siteUrl'] as String,
      youtubeId: json['youtubeId'] as String,
      key: json['key'] as String,
      shapeKey: json['shapeKey'] as String,
      stdKey: json['stdKey'] as String,
      stdShapeKey: json['stdShapeKey'] as String,
      tuning: json['tuning'] as String,
      capo: json['capo'] as int,
      level: json['level'] as int,
      font: json['font'] as String,
      composers: json['composers'] as String,
      verified: json['verified'] as bool,
      blocked: json['blocked'] as bool,
      reason: json['reason'] as String,
      chords: (json['chords'] as List<dynamic>?)?.map((e) => ChordDto.fromJson(e as Map<String, dynamic>)).toList(),
      music: MusicDto.fromJson(json['music'] as Map<String, dynamic>),
      artist: json['artist'] == null ? null : ArtistDto.fromJson(json['artist'] as Map<String, dynamic>),
      videoLesson: json['videoLesson'] == null
          ? null
          : VersionDataVideoLessonDto.fromJson(json['videoLesson'] as Map<String, dynamic>),
      contributors: (json['contributors'] as List<dynamic>?)
          ?.map((e) => ContributorDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      songsDetail: (json['versions'] as List<dynamic>?)
          ?.map((e) => VersionDataSongsDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
