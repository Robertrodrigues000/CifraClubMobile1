import 'package:cifraclub/data/songbook/models/songbook_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_version_dto.g.dart';

@JsonSerializable()
class SongbookVersionDto extends Equatable {
  @JsonKey(name: "id")
  final int? remoteDatabaseID;
  final int songId;
  @JsonKey(name: "cifraId")
  final int versionId;
  final int type;
  final String name;
  final String songUrl;
  final String? tone;
  final String? stdTone;
  final int? capo;
  final String? tuning;
  final SongbookVersionArtistDto artist;

  const SongbookVersionDto({
    this.remoteDatabaseID,
    required this.type,
    required this.name,
    required this.songUrl,
    required this.songId,
    this.tone,
    this.stdTone,
    this.capo,
    this.tuning,
    required this.artist,
    required this.versionId,
  });

  factory SongbookVersionDto.fromJson(Map<String, dynamic> json) => _$SongbookVersionDtoFromJson(json);

  Version toDomain(int order) {
    return Version(
      songId: songId,
      type: type,
      name: name,
      songUrl: songUrl,
      tone: tone,
      stdTone: stdTone,
      capo: capo,
      tuning: tuning,
      artist: artist.toDomain(),
      remoteDatabaseID: remoteDatabaseID,
      versionId: versionId,
      order: order,
    );
  }

  @override
  List<Object?> get props =>
      [songId, type, name, songUrl, tone, capo, tuning, artist, remoteDatabaseID, versionId]; // coverage:ignore-line
}
