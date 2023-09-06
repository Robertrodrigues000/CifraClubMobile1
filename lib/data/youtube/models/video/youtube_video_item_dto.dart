import 'package:cifraclub/data/youtube/models/video/youtube_video_content_details_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_statistics_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_item_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoItemDto {
  final String id;
  @JsonKey(name: "contentDetails")
  final YouTubeVideoContentDetailsDto contentDetails;
  @JsonKey(name: "statistics")
  final YouTubeVideoStatisticsDto statistics;

  const YouTubeVideoItemDto(this.id, this.contentDetails, this.statistics);

  factory YouTubeVideoItemDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoItemDtoFromJson(json);
}
