import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_data_video_lesson_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDataVideoLessonDto {
  final int id;
  final String youtubeId;
  final String title;
  final int hits;
  final String thumb;

  VersionDataVideoLessonDto({
    required this.id,
    required this.youtubeId,
    required this.title,
    required this.hits,
    required this.thumb,
  });

  factory VersionDataVideoLessonDto.fromJson(Map<String, dynamic> json) => _$VersionDataVideoLessonDtoFromJson(json);

  VersionDataVideoLesson toDomain() =>
      VersionDataVideoLesson(id: id, youtubeId: youtubeId, title: title, hits: hits, thumb: thumb);
}
