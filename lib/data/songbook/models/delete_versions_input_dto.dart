import 'package:json_annotation/json_annotation.dart';

part 'delete_versions_input_dto.g.dart';

@JsonSerializable(createFactory: false)
class DeleteVersionsInputDto {
  @JsonKey(name: "songs")
  final List<int> songsIds;

  const DeleteVersionsInputDto(this.songsIds);

  Map<String, dynamic> toJson() => _$DeleteVersionsInputDtoToJson(this);
}
