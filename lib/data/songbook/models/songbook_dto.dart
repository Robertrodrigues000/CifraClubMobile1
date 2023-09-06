import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

part 'songbook_dto.g.dart';

@JsonSerializable()
class SongbookDto {
  final int? id;
  final String? name;
  final String? userName;
  final int? userId;
  final String? thumb;
  final String? type;
  @JsonKey(name: "public")
  final bool? isPublic;
  final int? status;
  final int? totalSongs;
  final String? createdAt;
  @JsonKey(name: "lastUpdate")
  final String? lastUpdated;
  final int? timestamp;
  @JsonKey(name: "songs")
  final List<SongbookVersionDto>? versions;
  @JsonKey(name: "thumbURLs")
  final List<String>? preview;

  SongbookDto(
      {this.id,
      this.name,
      this.userName,
      this.userId,
      this.thumb,
      this.type,
      this.isPublic,
      this.status,
      this.totalSongs,
      this.createdAt,
      this.lastUpdated,
      this.timestamp,
      this.versions,
      this.preview});

  factory SongbookDto.fromJson(Map<String, dynamic> json) => _$SongbookDtoFromJson(json);

  ({Songbook songbook, List<Version> versions}) toDomain() => (
        songbook: Songbook(
          id: id,
          userId: userId,
          userName: userName,
          thumb: thumb,
          isPublic: isPublic ?? true,
          status: status,
          createdAt: DateTime.parse(createdAt ?? ""),
          lastUpdated: DateTime.tryParse(lastUpdated ?? ""),
          name: name ?? "",
          type: _getListType(type ?? ""),
          totalSongs: totalSongs ?? 0,
          preview: preview ?? [],
        ),
        versions: versions?.mapIndexed((index, e) => e.toDomain(index)).toList() ?? [],
      );

  ListType _getListType(String type) {
    switch (type) {
      case "default":
        return ListType.user;
      case "canplay":
        return ListType.canPlay;
      case "cantplay":
        return ListType.cantPlay;
      case "favorites":
        return ListType.favorites;
      case "recents":
        return ListType.recents;
      default:
        return ListType.user;
    }
  }
}
