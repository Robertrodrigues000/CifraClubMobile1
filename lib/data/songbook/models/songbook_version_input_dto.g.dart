// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_version_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SongbookVersionInputDtoToJson(SongbookVersionInputDto instance) {
  final val = <String, dynamic>{
    'artistDns': instance.artistUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('capo', instance.capo);
  writeNotNull('cifraId', instance.versionId);
  writeNotNull('id', instance.id);
  writeNotNull('instrumentType', instance.instrument);
  val['songDns'] = instance.songUrl;
  writeNotNull('tone', instance.tone);
  writeNotNull('tuning', instance.tuning);
  writeNotNull('type', instance.type);
  writeNotNull('versionLabel', instance.versionLabel);
  return val;
}
