// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDto _$NewsDtoFromJson(Map<String, dynamic> json) => NewsDto(
      url: json['url'] as String,
      image: json['image'] as String,
      thumb: json['thumb'] == null ? null : PhotoDto.fromJson(json['thumb'] as Map<String, dynamic>),
      headline: json['headline'] as String,
      publishDate: json['publishDate'] as String,
    );
