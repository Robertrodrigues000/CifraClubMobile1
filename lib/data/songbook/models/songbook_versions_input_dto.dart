import 'package:cifraclub/data/songbook/models/songbook_version_input_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_versions_input_dto.g.dart';

@JsonSerializable(createFactory: false)
class SongbookVersionsInputDto {
  final List<SongbookVersionInputDto> versionsInput;

  SongbookVersionsInputDto({
    required this.versionsInput,
  });

  SongbookVersionsInputDto.fromDomain(List<SongbookVersionInput> versions)
      : this(versionsInput: versions.map(SongbookVersionInputDto.fromDomain).toList());

  Map<String, dynamic> toJson() => _$SongbookVersionsInputDtoToJson(this);
}
