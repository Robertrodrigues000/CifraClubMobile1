// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_artists_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopArtistsDto _$TopArtistsDtoFromJson(Map<String, dynamic> json) => TopArtistsDto(
      moreResults: json['moreResults'] as bool,
      artists: (json['artists'] as List<dynamic>).map((e) => ArtistDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
