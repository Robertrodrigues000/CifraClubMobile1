// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_data_songs_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDataSongsDetailDto _$VersionDataSongsDetailDtoFromJson(Map<String, dynamic> json) => VersionDataSongsDetailDto(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => VersionDataSongDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      label: json['label'] as String,
      type: json['type'] as int,
    );
