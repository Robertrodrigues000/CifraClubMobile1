// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_version_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongbookVersionDto _$SongbookVersionDtoFromJson(Map<String, dynamic> json) => SongbookVersionDto(
      remoteDatabaseID: json['id'] as int?,
      type: json['type'] as int,
      name: json['name'] as String,
      songUrl: json['songUrl'] as String,
      songId: json['songId'] as int,
      tone: json['tone'] as String?,
      stdTone: json['stdTone'] as String?,
      capo: json['capo'] as int?,
      tuning: json['tuning'] as String?,
      artist: SongbookVersionArtistDto.fromJson(json['artist'] as Map<String, dynamic>),
      versionId: json['cifraId'] as int,
    );

Map<String, dynamic> _$SongbookVersionDtoToJson(SongbookVersionDto instance) => <String, dynamic>{
      'id': instance.remoteDatabaseID,
      'songId': instance.songId,
      'cifraId': instance.versionId,
      'type': instance.type,
      'name': instance.name,
      'songUrl': instance.songUrl,
      'tone': instance.tone,
      'stdTone': instance.stdTone,
      'capo': instance.capo,
      'tuning': instance.tuning,
      'artist': instance.artist,
    };
