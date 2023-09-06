// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_video_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YouTubeVideoItemDto _$YouTubeVideoItemDtoFromJson(Map<String, dynamic> json) => YouTubeVideoItemDto(
      json['id'] as String,
      YouTubeVideoContentDetailsDto.fromJson(json['contentDetails'] as Map<String, dynamic>),
      YouTubeVideoStatisticsDto.fromJson(json['statistics'] as Map<String, dynamic>),
    );
