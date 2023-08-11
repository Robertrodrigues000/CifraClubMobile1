import 'package:cifraclub/data/songbook/models/songbook_version_artist_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_version_dto.g.dart';

@JsonSerializable()
class SongbookVersionDto extends Equatable {
  @JsonKey(name: "id")
  final int? remoteDatabaseId;
  final int songId;
  @JsonKey(name: "cifraId")
  final int versionId;
  final int type;
  final String name;
  final String songUrl;
  @JsonKey(name: "tone")
  final String? key;
  @JsonKey(name: "stdTone")
  final String? stdKey;
  final int? capo;
  final String? tuning;
  final SongbookVersionArtistDto artist;

  const SongbookVersionDto({
    this.remoteDatabaseId,
    required this.type,
    required this.name,
    required this.songUrl,
    required this.songId,
    this.key,
    this.stdKey,
    this.capo,
    this.tuning,
    required this.artist,
    required this.versionId,
  });

  factory SongbookVersionDto.fromJson(Map<String, dynamic> json) => _$SongbookVersionDtoFromJson(json);

  Version toDomain(int order) {
    return Version(
      songId: songId,
      instrument: Instrument.getInstrumentByType(type) ?? Instrument.unknown,
      name: name,
      songUrl: songUrl,
      key: key,
      stdKey: stdKey,
      capo: capo,
      tuning: tuning,
      artist: artist.toDomain(),
      remoteDatabaseId: remoteDatabaseId,
      versionId: versionId,
      order: order,
    );
  }

  @override
  List<Object?> get props =>
      [songId, type, name, songUrl, key, capo, tuning, artist, remoteDatabaseId, versionId]; // coverage:ignore-line
}
