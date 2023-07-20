// coverage:ignore-file
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_songs_state.g.dart';

@CopyWith()
class ArtistSongsState {
  final String artistName;
  final List<String> songs;
  final List<VideoLesson> videoLessons;
  final RequestError? error;

  ArtistSongsState({
    this.songs = const [],
    this.videoLessons = const [],
    required this.artistName,
    this.error,
  });
}
