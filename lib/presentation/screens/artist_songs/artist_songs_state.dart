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
  final List<ArtistSong> songsFilteredBySearch;
  final List<String> alphabeticalPrefixes;
  final List<String> rankingPrefixes;
  final List<VideoLesson> videoLessons;
  final List<VideoLesson> videoLessonsFilteredBySearch;
  final RequestError? songsError;
  final RequestError? videoLessonsError;
  final Instrument? instrument;
  final bool isLoading;
  final bool shouldShowSearch;

  ArtistSongsState({
    this.songs = const [],
    this.songsFilteredBySearch = const [],
    this.alphabeticalPrefixes = const [],
    this.rankingPrefixes = const [],
    this.videoLessons = const [],
    this.videoLessonsFilteredBySearch = const [],
    this.instrument,
    this.songsError,
    this.videoLessonsError,
    this.isLoading = false,
    this.shouldShowSearch = false,
  });
}
