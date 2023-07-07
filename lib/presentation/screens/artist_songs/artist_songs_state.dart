// coverage:ignore-file
import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_songs_state.g.dart';

@CopyWith()
class ArtistSongsState {
  final String artistName;
  final List<String> songs;
  final List<String> videoLessons;

  ArtistSongsState({this.songs = const [], this.videoLessons = const [], required this.artistName});
}
