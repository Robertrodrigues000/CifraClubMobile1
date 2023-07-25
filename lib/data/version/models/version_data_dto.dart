import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/data/version/models/chord_dto.dart';
import 'package:cifraclub/data/version/models/contributor_dto.dart';
import 'package:cifraclub/data/version/models/music_dto.dart';
import 'package:cifraclub/data/version/models/version_data_songs_detail_dto.dart';
import 'package:cifraclub/data/version/models/version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_data_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDataDto {
  final int id;
  final int type;
  final int status;
  final String content;
  final String label;
  final String versionUrl;
  final String instrumentUrl;
  final int hits;
  final String url;
  final String siteUrl;
  final String youtubeId;
  final String key;
  final String shapeKey;
  final String stdKey;
  final String stdShapeKey;
  final String tuning;
  final int capo;
  final int level;
  final String font;
  final String composers;
  final bool verified;
  final bool blocked;
  final String reason;
  final List<ChordDto>? chords;
  final MusicDto music;
  final ArtistDto? artist;
  final VersionDataVideoLessonDto? videoLesson;
  final List<ContributorDto>? contributors;
  @JsonKey(name: 'versions')
  final List<VersionDataSongsDetailDto>? songsDetail;

  VersionDataDto({
    required this.id,
    required this.type,
    required this.status,
    required this.content,
    required this.label,
    required this.versionUrl,
    required this.instrumentUrl,
    required this.hits,
    required this.url,
    required this.siteUrl,
    required this.youtubeId,
    required this.key,
    required this.shapeKey,
    required this.stdKey,
    required this.stdShapeKey,
    required this.tuning,
    required this.capo,
    required this.level,
    required this.font,
    required this.composers,
    required this.verified,
    required this.blocked,
    required this.reason,
    required this.chords,
    required this.music,
    required this.artist,
    required this.videoLesson,
    required this.contributors,
    required this.songsDetail,
  });

  factory VersionDataDto.fromJson(Map<String, dynamic> json) => _$VersionDataDtoFromJson(json);

  VersionData toDomain() => VersionData(
      id: id,
      type: type,
      status: status,
      content: content,
      label: label,
      versionUrl: versionUrl,
      instrumentUrl: instrumentUrl,
      hits: hits,
      url: url,
      siteUrl: siteUrl,
      youtubeId: youtubeId,
      key: key,
      shapeKey: shapeKey,
      stdKey: stdKey,
      stdShapeKey: stdShapeKey,
      tuning: tuning,
      capo: capo,
      level: level,
      font: font,
      composers: composers,
      verified: verified,
      blocked: blocked,
      reason: reason,
      chords: chords?.map((e) => e.toDomain()).toList(),
      music: music.toDomain(),
      artist: artist?.toDomain(),
      videoLesson: videoLesson?.toDomain(),
      contributors: contributors?.map((e) => e.toDomain()).toList(),
      songsDetail: songsDetail?.map((e) => e.toDomain()).toList());
}
