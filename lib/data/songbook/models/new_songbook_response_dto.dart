import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_songbook_response_dto.g.dart';

/// This class was necessary due to
/// `public` being a integer instead of a boolean
@JsonSerializable(createToJson: false)
class NewSongbookResponseDto {
  final int id;
  final String name;
  @JsonKey(name: "public")
  final int isPublic;
  @JsonKey(name: "songs")
  final List<SongbookVersionDto>? versions;

  NewSongbookResponseDto({
    required this.id,
    required this.name,
    this.isPublic = 1,
    this.versions,
  });

  factory NewSongbookResponseDto.fromJson(Map<String, dynamic> json) => _$NewSongbookResponseDtoFromJson(json);

  ({Songbook songbook, Version? version}) toDomain(DateTime createdAt) {
    return (
      songbook: Songbook(
        id: id,
        name: name,
        isPublic: isPublic == 1,
        type: ListType.user,
        totalSongs: versions?.length ?? 0,
        createdAt: createdAt,
        preview: const [],
      ),
      version: versions?.map((e) => e.toDomain()).toList(growable: false).firstOrNull
    );
  }
}
