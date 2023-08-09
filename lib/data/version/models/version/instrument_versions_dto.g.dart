// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument_versions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstrumentVersionsDto _$InstrumentVersionsDtoFromJson(Map<String, dynamic> json) => InstrumentVersionsDto(
      versions: (json['songs'] as List<dynamic>?)
          ?.map((e) => InstrumentVersionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      label: json['label'] as String,
      type: json['type'] as int,
    );
