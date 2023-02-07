// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongDto _$SongDtoFromJson(Map<String, dynamic> json) => SongDto(
      artist: json['artist'] == null ? null : ArtistDto.fromJson(json['artist'] as Map<String, dynamic>),
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      isVerified: json['verified'] as bool?,
    );
