// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument_version_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstrumentVersionDto _$InstrumentVersionDtoFromJson(Map<String, dynamic> json) => InstrumentVersionDto(
      versionId: json['id'] as int,
      label: json['label'] as String,
      versionUrl: json['versionUrl'] as String,
      videoLesson: json['videoLesson'] == null
          ? null
          : VersionDataVideoLessonDto.fromJson(json['videoLesson'] as Map<String, dynamic>),
      completePath: json['url'] as String,
      isVerified: json['verified'] as bool,
    );
