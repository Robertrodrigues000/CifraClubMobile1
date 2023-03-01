// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighlightDto _$HighlightDtoFromJson(Map<String, dynamic> json) => HighlightDto(
      url: json['url'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String,
      imageDescription: json['alt'] as String,
      photos: PhotosDto.fromJson(json['photos'] as Map<String, dynamic>),
    );
