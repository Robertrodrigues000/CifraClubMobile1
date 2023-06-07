// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistInfoDto _$ArtistInfoDtoFromJson(Map<String, dynamic> json) => ArtistInfoDto(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      hitsCount: json['hits'] as int,
      genre: GenreDto.fromJson(json['genre'] as Map<String, dynamic>),
      imagesDto: json['image'] == null ? null : ArtistImageDto.fromJson(json['image'] as Map<String, dynamic>),
      headImageDto:
          json['headImage'] == null ? null : ArtistImageDto.fromJson(json['headImage'] as Map<String, dynamic>),
    );
