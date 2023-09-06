import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_content_details_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoContentDetailsDto {
  final String duration;

  const YouTubeVideoContentDetailsDto(this.duration);

  factory YouTubeVideoContentDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$YouTubeVideoContentDetailsDtoFromJson(json);
}
