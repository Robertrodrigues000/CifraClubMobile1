import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/version/models/version/chord_dto.dart';
import 'package:cifraclub/data/version/models/version/contributor_dto.dart';
import 'package:cifraclub/data/version/models/version/version_data_song_dto.dart';
import 'package:cifraclub/data/version/models/version/instrument_versions_dto.dart';
import 'package:cifraclub/data/version/models/version/version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_data_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDataDto {
  @JsonKey(name: 'id')
  final int versionId;
  final int type;
  final String content;
  final String label;
  final String versionUrl;
  @JsonKey(name: 'url')
  final String completePath;
  final String siteUrl;
  final String key;
  final String shapeKey;
  final String stdKey;
  final String stdShapeKey;
  final String tuning;
  final int capo;
  final String composers;
  @JsonKey(name: 'verified')
  final bool isVerified;
  final bool blocked;
  final String reason;
  final List<ChordDto>? chords;
  @JsonKey(name: 'music')
  final VersionDataSongDto song;
  final ArtistDto? artist;
  final VersionDataVideoLessonDto? videoLesson;
  final List<ContributorDto>? contributors;
  @JsonKey(name: 'versions')
  final List<InstrumentVersionsDto>? instrumentVersions;

  VersionDataDto({
    required this.versionId,
    required this.type,
    required this.content,
    required this.label,
    required this.versionUrl,
    required this.completePath,
    required this.siteUrl,
    required this.key,
    required this.shapeKey,
    required this.stdKey,
    required this.stdShapeKey,
    required this.tuning,
    required this.capo,
    required this.composers,
    required this.isVerified,
    required this.blocked,
    required this.reason,
    required this.chords,
    required this.song,
    required this.artist,
    required this.videoLesson,
    required this.contributors,
    required this.instrumentVersions,
  });

  factory VersionDataDto.fromJson(Map<String, dynamic> json) => _$VersionDataDtoFromJson(json);

  VersionData toDomain() => VersionData(
      versionId: versionId,
      type: type,
      content: content,
      label: label,
      versionUrl: versionUrl,
      completePath: completePath,
      siteUrl: siteUrl,
      key: key,
      shapeKey: shapeKey,
      stdKey: stdKey,
      stdShapeKey: stdShapeKey,
      tuning: tuning,
      capo: capo,
      composers: composers,
      isVerified: isVerified,
      blocked: blocked,
      reason: reason,
      chords: chords?.map((e) => e.toDomain()).toList(),
      song: song.toDomain(),
      artist: artist?.toDomain(),
      videoLesson: videoLesson?.toDomain(),
      contributors: contributors?.map((e) => e.toDomain()).toList(),
      instrumentVersions: instrumentVersions?.map((e) => e.toDomain()).toList());
}
