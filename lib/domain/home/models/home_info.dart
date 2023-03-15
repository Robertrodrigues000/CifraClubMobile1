import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/domain/home/models/news.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:equatable/equatable.dart';

class HomeInfo extends Equatable {
  final List<Highlight>? highlights;
  final List<Song>? songs;
  final List<Artist>? artists;
  final List<VideoLesson>? videoLessons;
  final List<News>? news;

  const HomeInfo({
    required this.highlights,
    required this.songs,
    required this.artists,
    required this.videoLessons,
    required this.news,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [highlights, songs, artists, videoLessons, news];
  // coverage:ignore-end
}
