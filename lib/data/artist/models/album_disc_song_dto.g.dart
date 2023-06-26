// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_disc_song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDiscSongDto _$AlbumDiscSongDtoFromJson(Map<String, dynamic> json) => AlbumDiscSongDto(
      disc: json['disk'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      order: json['order'] as int,
      artistSong: json['song'] == null ? null : ArtistSongDto.fromJson(json['song'] as Map<String, dynamic>),
    );
