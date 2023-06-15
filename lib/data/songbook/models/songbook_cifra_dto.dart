import 'package:cifraclub/data/songbook/models/songbook_cifra_artist_dto.dart';
import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_cifra_dto.g.dart';

@JsonSerializable()
class SongbookCifraDto extends Equatable {
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
  final SongbookCifraArtistDto artist;

  const SongbookCifraDto({
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

  factory SongbookCifraDto.fromJson(Map<String, dynamic> json) => _$SongbookCifraDtoFromJson(json);

  Cifra toDomain() {
    return Cifra(
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
    );
  }

  @override
  List<Object?> get props =>
      [songId, type, name, songUrl, tone, capo, tuning, artist, remoteDatabaseID, versionId]; // coverage:ignore-line
}
