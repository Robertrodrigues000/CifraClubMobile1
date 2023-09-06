import 'package:cifraclub/data/youtube/models/search/youtube_search_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'youtube_search_items_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeSearchItemsDto {
  final List<YouTubeSearchItemDto> items;

  const YouTubeSearchItemsDto(this.items);

  factory YouTubeSearchItemsDto.fromJson(Map<String, dynamic> json) => _$YouTubeSearchItemsDtoFromJson(json);
}
