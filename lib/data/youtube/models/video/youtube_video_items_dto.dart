import 'package:cifraclub/data/youtube/models/video/youtube_video_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_items_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoItemsDto {
  final List<YouTubeVideoItemDto> items;

  const YouTubeVideoItemsDto(this.items);

  factory YouTubeVideoItemsDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoItemsDtoFromJson(json);
}
