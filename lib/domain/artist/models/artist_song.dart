import 'package:equatable/equatable.dart';

class ArtistSong extends Equatable {
  final int id;
  final int lyrics;
  final int lyricsId;
  final String name;
  final int sheet;
  final String url;
  final bool verified;
  final int videoLessons;
  final List<int> videoLessonsInstruments;

  const ArtistSong(
      {required this.id,
      required this.lyrics,
      required this.lyricsId,
      required this.name,
      required this.sheet,
      required this.url,
      required this.verified,
      required this.videoLessons,
      required this.videoLessonsInstruments});

  @override
  List<Object?> get props => [id, lyricsId, url, name];
}
