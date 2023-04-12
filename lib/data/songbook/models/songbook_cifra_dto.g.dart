// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_cifra_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongbookCifraDto _$SongbookCifraDtoFromJson(Map<String, dynamic> json) => SongbookCifraDto(
      id: json['id'] as int,
      name: json['name'] as String,
      songUrl: json['songUrl'] as String,
      tone: json['tone'] as String?,
      type: json['type'] as int,
    );

Map<String, dynamic> _$SongbookCifraDtoToJson(SongbookCifraDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'songUrl': instance.songUrl,
      'tone': instance.tone,
      'type': instance.type,
    };
