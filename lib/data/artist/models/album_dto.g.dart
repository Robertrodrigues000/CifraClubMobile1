// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDto _$AlbumDtoFromJson(Map<String, dynamic> json) => AlbumDto(
      artistName: json['artistName'] as String,
      id: json['id'] as int,
      artistUrl: json['dns'] as String,
      image: json['image'] == null ? null : AlbumImageDto.fromJson(json['image'] as Map<String, dynamic>),
      recordCompany: json['recordCompany'] as String?,
      releaseYear: json['releaseYear'] as int?,
      title: json['title'] as String,
      totalSongs: json['totalSongs'] as int?,
      albumUrl: json['url'] as String,
      totalSongsRelated: json['totalSongsRelated'] as int?,
    );
