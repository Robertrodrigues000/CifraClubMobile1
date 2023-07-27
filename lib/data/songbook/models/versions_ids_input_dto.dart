import 'package:json_annotation/json_annotation.dart';

part 'versions_ids_input_dto.g.dart';

@JsonSerializable(createFactory: false)
class VersionsIdsInputDto {
  @JsonKey(name: "songs")
  final List<int> versionsIds;

  const VersionsIdsInputDto(this.versionsIds);

  Map<String, dynamic> toJson() => _$VersionsIdsInputDtoToJson(this);
}
