import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'top_songs_state.g.dart';

@CopyWith()
class TopSongsState {
  final String? selectedGenre;
  final List<Genre> genres;
  final List<Song> topSongs;
  final RequestError? error;
  final bool isLoadingSongs;

  TopSongsState({
    this.selectedGenre,
    this.genres = const [],
    this.topSongs = const [],
    this.error,
    this.isLoadingSongs = false,
  });
}
