import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/home/models/home_image.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:equatable/equatable.dart';

class VideoLessons extends Equatable {
  final int id;
  final String youtubeId;
  final String title;
  final String url;
  final int views;
  final int duration;
  final String urlApi;
  final List<String> instrumentsId;
  final Song? song;
  final Artist? artist;
  final HomeImage images;

  const VideoLessons({
    required this.id,
    required this.youtubeId,
    required this.title,
    required this.url,
    required this.views,
    required this.duration,
    required this.urlApi,
    required this.instrumentsId,
    this.song,
    this.artist,
    required this.images,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [id, youtubeId, title, url, song, artist];
  // coverage:ignore-end
}
