import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:json_annotation/json_annotation.dart';
part 'artist_song_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistSongDto {
  final int bass;
  final int drums;
  final int guitar;
  final int guitarpro;
  final int harmonica;
  final int hits;
  final int id;
  final int lyrics;
  final int lyricsId;
  final String name;
  final int sheet;
  final String url;
  final bool verified;
  final int videoLessons;
  final List<int>? videoLessonsInstruments;

  const ArtistSongDto(
      {required this.bass,
      required this.drums,
      required this.guitar,
      required this.guitarpro,
      required this.harmonica,
      required this.hits,
      required this.id,
      required this.lyrics,
      required this.lyricsId,
      required this.name,
      required this.sheet,
      required this.url,
      required this.verified,
      required this.videoLessons,
      this.videoLessonsInstruments});

  ArtistSong toDomain() => ArtistSong(
        id: id,
        lyrics: lyrics,
        lyricsId: lyricsId,
        name: name,
        bass: bass,
        drums: drums,
        guitar: guitar,
        guitarpro: guitarpro,
        harmonica: harmonica,
        sheet: sheet,
        url: url,
        verified: verified,
        videoLessons: videoLessons,
      );

  factory ArtistSongDto.fromJson(Map<String, dynamic> json) => _$ArtistSongDtoFromJson(json);
}
