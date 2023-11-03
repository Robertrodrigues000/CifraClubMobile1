// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SongbookInputDtoToJson(SongbookInputDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['public'] = instance.isPublic;
  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('songs', instance.versionsInput);
  return val;
}
