// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongbookInputDto _$SongbookInputDtoFromJson(Map<String, dynamic> json) => SongbookInputDto(
      name: json['name'] as String,
      isPublic: json['public'] as bool? ?? true,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$SongbookInputDtoToJson(SongbookInputDto instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'public': instance.isPublic,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('timestamp', instance.timestamp);
  return val;
}
