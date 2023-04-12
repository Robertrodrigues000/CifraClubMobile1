// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongbookDto _$SongbookDtoFromJson(Map<String, dynamic> json) => SongbookDto(
      id: json['id'] as int?,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      userId: json['userId'] as int?,
      thumb: json['thumb'] as String?,
      type: json['type'] as String?,
      isPublic: json['public'] as bool?,
      status: json['status'] as int?,
      totalSongs: json['totalSongs'] as int?,
      createdAt: json['createdAt'] as String?,
      lastUpdated: json['lastUpdate'] as String?,
      timestamp: json['timestamp'] as int?,
      cifras:
          (json['songs'] as List<dynamic>?)?.map((e) => SongbookCifraDto.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$SongbookDtoToJson(SongbookDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userName': instance.userName,
      'userId': instance.userId,
      'thumb': instance.thumb,
      'type': instance.type,
      'public': instance.isPublic,
      'status': instance.status,
      'totalSongs': instance.totalSongs,
      'createdAt': instance.createdAt,
      'lastUpdate': instance.lastUpdated,
      'timestamp': instance.timestamp,
      'songs': instance.cifras,
    };
