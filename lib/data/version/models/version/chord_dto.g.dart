// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chord_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChordDto _$ChordDtoFromJson(Map<String, dynamic> json) => ChordDto(
      name: json['chord'] as String,
      shapeName: json['alt'] as String,
      guitar: (json['guitar'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cavaco: (json['cavaco'] as List<dynamic>?)?.map((e) => e as String).toList(),
      keyboard: (json['keyboard'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ukulele: (json['ukulele'] as List<dynamic>?)?.map((e) => e as String).toList(),
      viola: (json['viola'] as List<dynamic>?)?.map((e) => e as String).toList(),
      violaMi: (json['viola_mi'] as List<dynamic>?)?.map((e) => e as String).toList(),
      violaRa: (json['viola_ra'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
