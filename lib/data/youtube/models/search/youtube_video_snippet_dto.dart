import 'package:cifraclub/data/youtube/models/search/youtube_video_images_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_snippet_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoSnippetDto {
  final String title;
  @JsonKey(name: "thumbnails")
  final YouTubeVideoImagesDto youTubeVideoImages;

  const YouTubeVideoSnippetDto(this.title, this.youTubeVideoImages);

  factory YouTubeVideoSnippetDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoSnippetDtoFromJson(json);
}
