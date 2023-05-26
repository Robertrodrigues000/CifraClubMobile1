import 'package:json_annotation/json_annotation.dart';

part 'delete_songs_input_dto.g.dart';

@JsonSerializable(createFactory: false)
class DeleteCifrasInputDto {
  @JsonKey(name: "songs")
  final List<int> songsIds;

  const DeleteCifrasInputDto(this.songsIds);

  Map<String, dynamic> toJson() => _$DeleteCifrasInputDtoToJson(this);
}
