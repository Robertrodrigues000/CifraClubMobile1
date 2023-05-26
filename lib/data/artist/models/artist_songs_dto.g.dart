// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_songs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistSongsDto _$ArtistSongsDtoFromJson(Map<String, dynamic> json) => ArtistSongsDto(
      songs: (json['songs'] as List<dynamic>).map((e) => ArtistSongDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
