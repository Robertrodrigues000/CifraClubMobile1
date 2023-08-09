// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDataDto _$VersionDataDtoFromJson(Map<String, dynamic> json) => VersionDataDto(
      versionId: json['id'] as int,
      type: json['type'] as int,
      content: json['content'] as String,
      label: json['label'] as String,
      versionUrl: json['versionUrl'] as String,
      completePath: json['url'] as String,
      siteUrl: json['siteUrl'] as String,
      key: json['key'] as String,
      shapeKey: json['shapeKey'] as String,
      stdKey: json['stdKey'] as String,
      stdShapeKey: json['stdShapeKey'] as String,
      tuning: json['tuning'] as String,
      capo: json['capo'] as int,
      composers: json['composers'] as String,
      isVerified: json['verified'] as bool,
      blocked: json['blocked'] as bool,
      reason: json['reason'] as String,
      chords: (json['chords'] as List<dynamic>?)?.map((e) => ChordDto.fromJson(e as Map<String, dynamic>)).toList(),
      song: VersionDataSongDto.fromJson(json['music'] as Map<String, dynamic>),
      artist: json['artist'] == null ? null : ArtistDto.fromJson(json['artist'] as Map<String, dynamic>),
      videoLesson: json['videoLesson'] == null
          ? null
          : VersionDataVideoLessonDto.fromJson(json['videoLesson'] as Map<String, dynamic>),
      contributors: (json['contributors'] as List<dynamic>?)
          ?.map((e) => ContributorDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      instrumentVersions: (json['versions'] as List<dynamic>?)
          ?.map((e) => InstrumentVersionsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
