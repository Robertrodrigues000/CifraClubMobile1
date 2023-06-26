// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_disc_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDiscDto _$AlbumDiscDtoFromJson(Map<String, dynamic> json) => AlbumDiscDto(
      songs: (json['songs'] as List<dynamic>).map((e) => AlbumDiscSongDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
