// coverage:ignore-file
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_songs_state.g.dart';

@CopyWith()
class ArtistSongsState {
  final List<String> songs;
  final List<VideoLesson> videoLessons;
  final RequestError? error;
  final Instrument? instrument;

  ArtistSongsState({
    this.songs = const [],
    this.videoLessons = const [],
    this.error,
    this.instrument,
  });
}
