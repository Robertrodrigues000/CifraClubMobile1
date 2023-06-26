// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDetailDto _$AlbumDetailDtoFromJson(Map<String, dynamic> json) => AlbumDetailDto(
      artistName: json['artistName'] as String,
      discs: (json['discs'] as List<dynamic>).map((e) => AlbumDiscDto.fromJson(e as Map<String, dynamic>)).toList(),
      id: json['id'] as int,
      artistUrl: json['dns'] as String,
      albumUrl: json['url'] as String,
      image: json['image'] == null ? null : AlbumImageDto.fromJson(json['image'] as Map<String, dynamic>),
      recordCompany: json['recordCompany'] as String?,
      releaseYear: json['releaseYear'] as int?,
      title: json['title'] as String,
      totalSongs: json['totalSongs'] as int?,
      totalSongsRelated: json['totalSongsRelated'] as int?,
    );
