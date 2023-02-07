// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_songs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSongsDto _$TopSongsDtoFromJson(Map<String, dynamic> json) => TopSongsDto(
      moreResults: json['moreResults'] as bool,
      songs: (json['songs'] as List<dynamic>).map((e) => SongDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
