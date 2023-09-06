import 'package:cifraclub/data/youtube/models/search/youtube_video_image_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_images_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoImagesDto {
  @JsonKey(name: "medium")
  final YouTubeVideoImageDto images;

  const YouTubeVideoImagesDto(this.images);

  factory YouTubeVideoImagesDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoImagesDtoFromJson(json);
}
