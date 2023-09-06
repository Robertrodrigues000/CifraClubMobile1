import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_image_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoImageDto {
  @JsonKey(name: "url")
  final String url;

  const YouTubeVideoImageDto(this.url);

  factory YouTubeVideoImageDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoImageDtoFromJson(json);
}
