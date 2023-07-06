import 'package:equatable/equatable.dart';

class ArtistSong extends Equatable {
  final int id;
  final int lyrics;
  final int lyricsId;
  final String name;
  final int bass;
  final int drums;
  final int guitar;
  final int guitarpro;
  final int harmonica;
  final int sheet;
  final String url;
  final bool verified;
  final int videoLessons;
  final List<int>? videoLessonsInstruments;

  const ArtistSong(
      {required this.id,
      required this.lyrics,
      required this.lyricsId,
      required this.name,
      required this.bass,
      required this.drums,
      required this.guitar,
      required this.guitarpro,
      required this.harmonica,
      required this.sheet,
      required this.url,
      required this.verified,
      required this.videoLessons,
      this.videoLessonsInstruments});

  @override
  List<Object?> get props => [id, lyricsId, url, name];
}
