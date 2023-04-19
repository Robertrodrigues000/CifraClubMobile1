import 'package:cifraclub/domain/home/models/version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDto {
  final int id;
  final int type;
  final String label;

  Version toDomain() => Version(id: id, type: type, label: label);

  factory VersionDto.fromJson(Map<String, dynamic> json) => _$VersionDtoFromJson(json);

  VersionDto({
    required this.id,
    required this.type,
    required this.label,
  });
}
