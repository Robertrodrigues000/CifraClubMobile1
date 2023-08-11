import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_version_input_dto.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class SongbookVersionInputDto {
  @JsonKey(name: "artistDns")
  final String? artistUrl;
  final int? capo;
  @JsonKey(name: "cifraId")
  final int? versionId;
  final int? id;
  @JsonKey(name: "instrumentType")
  final String? instrument;
  @JsonKey(name: "songDns")
  final String? songUrl;
  @JsonKey(name: "tone")
  final String? key;
  final String? tuning;
  final int? type;
  @JsonKey(name: "versionLabel")
  final String? versionLabel;

  SongbookVersionInputDto({
    required this.artistUrl,
    this.capo,
    required this.versionId,
    required this.id,
    this.instrument,
    required this.songUrl,
    this.key,
    this.tuning,
    this.type,
    this.versionLabel,
  });

  SongbookVersionInputDto.fromDomain(SongbookVersionInput versionInput)
      : this(
            id: versionInput.id,
            versionId: versionInput.versionId,
            artistUrl: versionInput.artistUrl,
            songUrl: versionInput.songUrl,
            instrument: versionInput.instrument,
            capo: versionInput.capo,
            key: versionInput.key,
            tuning: versionInput.tuning,
            type: versionInput.type,
            versionLabel: versionInput.versionLabel);

  Map<String, dynamic> toJson() => _$SongbookVersionInputDtoToJson(this);
}
