import 'package:cifraclub/data/version/models/version/version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instrument_version_dto.g.dart';

@JsonSerializable(createToJson: false)
class InstrumentVersionDto {
  @JsonKey(name: 'id')
  final int versionId;
  final String label;
  final String versionUrl;
  final VersionDataVideoLessonDto? videoLesson;
  @JsonKey(name: 'url')
  final String completePath;
  @JsonKey(name: 'verified')
  final bool isVerified;

  InstrumentVersionDto({
    required this.versionId,
    required this.label,
    required this.versionUrl,
    this.videoLesson,
    required this.completePath,
    required this.isVerified,
  });

  factory InstrumentVersionDto.fromJson(Map<String, dynamic> json) => _$InstrumentVersionDtoFromJson(json);

  InstrumentVersion toDomain() => InstrumentVersion(
        id: versionId,
        label: label,
        versionUrl: versionUrl,
        videoLesson: videoLesson?.toDomain(),
        completePath: completePath,
        isVerified: isVerified,
      );
}
