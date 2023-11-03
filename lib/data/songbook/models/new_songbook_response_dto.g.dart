// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_songbook_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewSongbookResponseDto _$NewSongbookResponseDtoFromJson(Map<String, dynamic> json) => NewSongbookResponseDto(
      id: json['id'] as int,
      name: json['name'] as String,
      isPublic: json['public'] as int? ?? 1,
      versions: (json['songs'] as List<dynamic>?)
          ?.map((e) => SongbookVersionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
