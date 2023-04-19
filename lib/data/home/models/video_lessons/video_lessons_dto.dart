import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/version_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_image_dto.dart';
import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cifraclub/domain/home/models/video_lesson.dart';

part 'video_lessons_dto.g.dart';

@JsonSerializable(createToJson: false)
class VideoLessonsDto extends Equatable {
  final int id;
  final String youtubeId;
  final String title;
  final String url;
  final int views;
  final int duration;
  final String urlApi;
  final List<String>? instruments;
  final SongDto? song;
  final ArtistDto? artist;
  final VideoLessonsImageDto? images;
  final VersionDto? version;

  VideoLesson toDomain() => VideoLesson(
        id: id,
        youtubeId: youtubeId,
        title: title,
        url: url,
        views: views,
        duration: duration,
        urlApi: urlApi,
        instrumentsId: instruments ?? List.empty(),
        images: images!.toDomain(),
        song: song?.toDomain(),
        artist: artist?.toDomain(),
        version: version?.toDomain(),
      );

  factory VideoLessonsDto.fromJson(Map<String, dynamic> json) => _$VideoLessonsDtoFromJson(json);

  const VideoLessonsDto({
    required this.id,
    required this.youtubeId,
    required this.title,
    required this.url,
    required this.views,
    required this.duration,
    required this.urlApi,
    required this.instruments,
    this.song,
    this.artist,
    this.images,
    this.version,
  });

  @override
  List<Object?> get props => [id, youtubeId, url, title];
}
