// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultDto _$SearchResultDtoFromJson(Map<String, dynamic> json) => SearchResultDto(
      docs: (json['docs'] as List<dynamic>?)?.map((e) => SearchDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
