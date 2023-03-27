// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/domain/home/models/news.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
part 'home_state.g.dart';

@CopyWith()
class HomeState {
  final String? selectedGenre;
  final List<Highlight> highlights;
  final List<Song> topCifras;
  final List<Artist> topArtists;
  final List<VideoLesson> videoLessons;
  final List<News> blog;
  final List<Genre> genres;
  final User? user;
  final bool isPro;
  final bool isLoading;
  final RequestError? error;

  const HomeState({
    this.highlights = const [],
    this.topCifras = const [],
    this.topArtists = const [],
    this.videoLessons = const [],
    this.blog = const [],
    this.selectedGenre,
    this.genres = const [],
    this.user,
    this.isPro = false,
    this.isLoading = false,
    this.error,
  });
}
