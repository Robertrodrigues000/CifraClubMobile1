import 'package:cifraclub/domain/home/models/video_lesson_version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_lesson_version_dto.g.dart';

@JsonSerializable(createToJson: false)
class VideoLessonVersionDto {
  final int id;
  final int type;
  final String label;

  VideoLessonVersion toDomain() => VideoLessonVersion(id: id, type: type, label: label);

  factory VideoLessonVersionDto.fromJson(Map<String, dynamic> json) => _$VideoLessonVersionDtoFromJson(json);

  VideoLessonVersionDto({
    required this.id,
    required this.type,
    required this.label,
  });
}
