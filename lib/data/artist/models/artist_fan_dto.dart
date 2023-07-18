// coverage:ignore-file

import 'package:json_annotation/json_annotation.dart';

part 'artist_fan_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistFanDto {
  final bool isFan;

  ArtistFanDto(this.isFan);

  factory ArtistFanDto.fromJson(Map<String, dynamic> json) => _$ArtistFanDtoFromJson(json);
}
