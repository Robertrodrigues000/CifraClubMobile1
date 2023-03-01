import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/home/models/highlight/highlights_dto.dart';
import 'package:cifraclub/data/home/models/news/news_dto.dart';
import 'package:cifraclub/data/home/models/video_lessons/video_lessons_dto.dart';
import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_dto.g.dart';

@JsonSerializable(createToJson: false)
class HomeDto extends Equatable {
  final HighlightsDto? highlights;
  final List<SongDto>? songs;
  final List<ArtistDto>? artists;
  final List<VideoLessonsDto>? videoLessons;
  final List<NewsDto>? news;

  factory HomeDto.fromJson(Map<String, dynamic> json) => _$HomeDtoFromJson(json);

  HomeInfo toDomain() => HomeInfo(
        highlights: highlights?.toDomain(),
        songs: songs?.map((e) => e.toDomain()).toList(),
        artists: artists?.map((e) => e.toDomain()).toList(),
        videoLessons: videoLessons?.map((e) => e.toDomain()).toList(),
        news: news?.map((e) => e.toDomain()).toList(),
      );

  const HomeDto({
    required this.highlights,
    required this.songs,
    required this.artists,
    required this.videoLessons,
    required this.news,
  });

  @override
  List<Object?> get props => [highlights, songs, artists, videoLessons, news];
}
