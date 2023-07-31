// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_songs_state.g.dart';

@CopyWith()
class ArtistSongsState {
  final List<ArtistSong> songs;
  final List<String> prefixes;
  final List<VideoLesson> videoLessons;
  final RequestError? songsError;
  final RequestError? videoLessonsError;
  final Instrument? instrument;
  final bool isLoading;

  ArtistSongsState(
      {this.songs = const [],
      this.prefixes = const [],
      this.videoLessons = const [],
      this.songsError,
      this.videoLessonsError,
      this.instrument,
      this.isLoading = false});
}
