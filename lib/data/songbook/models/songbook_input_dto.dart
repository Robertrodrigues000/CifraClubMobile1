// coverage:ignore-file
import 'package:cifraclub/data/songbook/models/songbook_version_input_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_input_dto.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class SongbookInputDto {
  final String? name;
  @JsonKey(name: "public")
  final bool isPublic;
  final String? timestamp;
  @JsonKey(name: "songs")
  final List<SongbookVersionInputDto>? versionsInput;

  SongbookInputDto({
    required this.name,
    required this.isPublic,
    this.timestamp,
    this.versionsInput,
  });

  Map<String, dynamic> toJson() => _$SongbookInputDtoToJson(this);
}
