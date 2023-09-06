import 'package:json_annotation/json_annotation.dart';

part 'youtube_video_statistics_dto.g.dart';

@JsonSerializable(createToJson: false)
class YouTubeVideoStatisticsDto {
  final String viewCount;

  const YouTubeVideoStatisticsDto(this.viewCount);

  factory YouTubeVideoStatisticsDto.fromJson(Map<String, dynamic> json) => _$YouTubeVideoStatisticsDtoFromJson(json);
}
