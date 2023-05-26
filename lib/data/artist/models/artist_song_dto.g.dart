// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_song_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistSongDto _$ArtistSongDtoFromJson(Map<String, dynamic> json) => ArtistSongDto(
      bass: json['bass'] as int,
      drums: json['drums'] as int,
      guitar: json['guitar'] as int,
      guitarpro: json['guitarpro'] as int,
      harmonica: json['harmonica'] as int,
      hits: json['hits'] as int,
      id: json['id'] as int,
      lyrics: json['lyrics'] as int,
      lyricsId: json['lyricsId'] as int,
      name: json['name'] as String,
      sheet: json['sheet'] as int,
      url: json['url'] as String,
      verified: json['verified'] as bool,
      videoLessons: json['videoLessons'] as int,
      videoLessonsInstruments: (json['videoLessonsInstruments'] as List<dynamic>).map((e) => e as int).toList(),
    );
