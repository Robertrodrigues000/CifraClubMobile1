// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'songbook_input_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class SongbookInputDto {
  final String? name;
  @JsonKey(name: "public")
  final bool isPublic;
  final String? timestamp;

  SongbookInputDto({
    required this.name,
    required this.isPublic,
    this.timestamp,
  });

  Map<String, dynamic> toJson() => _$SongbookInputDtoToJson(this);
}
