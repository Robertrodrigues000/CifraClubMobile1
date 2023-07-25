import 'package:cifraclub/data/version/models/version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_data_song_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDataSongDto {
  final int id;
  final String label;
  final int hits;
  final String versionUrl;
  final String instrumentUrl;
  final VersionDataVideoLessonDto? videoLesson;
  final int level;
  final String url;
  final bool verified;

  VersionDataSongDto({
    required this.id,
    required this.label,
    required this.hits,
    required this.versionUrl,
    required this.instrumentUrl,
    this.videoLesson,
    required this.level,
    required this.url,
    required this.verified,
  });

  factory VersionDataSongDto.fromJson(Map<String, dynamic> json) => _$VersionDataSongDtoFromJson(json);

  VersionDataSong toDomain() => VersionDataSong(
        id: id,
        label: label,
        hits: hits,
        versionUrl: versionUrl,
        instrumentUrl: instrumentUrl,
        videoLesson: videoLesson?.toDomain(),
        level: level,
        url: url,
        verified: verified,
      );
}
