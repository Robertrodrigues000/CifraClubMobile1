import 'package:cifraclub/data/artist/models/artist_song_dto.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_songs_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistSongsDto {
  final List<ArtistSongDto> songs;

  const ArtistSongsDto({required this.songs});

  factory ArtistSongsDto.fromJson(Map<String, dynamic> json) => _$ArtistSongsDtoFromJson(json);

  List<ArtistSong> toDomain() {
    return songs.map((song) => song.toDomain()).toList();
  }
}
