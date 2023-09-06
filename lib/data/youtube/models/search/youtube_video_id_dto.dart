import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_id_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoIdDto {
  final String videoId;

  const YouTubeVideoIdDto(this.videoId);

  factory YouTubeVideoIdDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoIdDtoFromJson(json);
}
