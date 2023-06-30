import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_song_input_dto.g.dart';

@JsonSerializable(createFactory: false)
class SongbookSongInputDto {
  @JsonKey(name: "artistDns")
  final String artistUrl;
  final int? capo;
  @JsonKey(name: "cifraId")
  final int versionId;
  final int id;
  @JsonKey(name: "instrumentType")
  final String? instrument;
  @JsonKey(name: "songDns")
  final String songUrl;
  final String? tone;
  final String? tuning;
  final int? type;
  @JsonKey(name: "versionLabel")
  final String? version;

  SongbookSongInputDto({
    required this.artistUrl,
    this.capo,
    required this.versionId,
    required this.id,
    this.instrument,
    required this.songUrl,
    this.tone,
    this.tuning,
    this.type,
    this.version,
  });

  SongbookSongInputDto.fromDomain(Version song)
      : this(
          id: song.remoteDatabaseID!,
          versionId: song.versionId,
          artistUrl: song.artist.url,
          songUrl: song.songUrl,
          instrument: Instrument.getInstrumentByType(song.type).instrumentUrl,
          capo: song.capo,
          tone: song.tone,
          tuning: song.tuning,
          type: song.type,
        );

  Map<String, dynamic> toJson() => _$SongbookSongInputDtoToJson(this);
}
