import 'package:cifraclub/data/youtube/models/search/youtube_video_id_dto.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_video_snippet_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'youtube_search_item_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeSearchItemDto {
  @JsonKey(name: "id")
  final YouTubeVideoIdDto youTubeVideoId;
  @JsonKey(name: "snippet")
  final YouTubeVideoSnippetDto youTubeVideoSnippet;

  const YouTubeSearchItemDto(this.youTubeVideoId, this.youTubeVideoSnippet);

  factory YouTubeSearchItemDto.fromJson(Map<String, dynamic> json) => _$YouTubeSearchItemDtoFromJson(json);
}
