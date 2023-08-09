import 'package:cifraclub/data/version/models/user_version/user_artist_image_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_chord_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_contributor_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_instrument_version_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_song_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_artist_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_genre_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_genre_images_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_instrument_versions_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_version_data_dto.g.dart';

@Collection(inheritance: false)
class UserVersionDataDto extends Equatable {
  final Id localId;
  final int versionId;
  final int songbookVersionId;
  final int type;
  final String content;
  final String label;
  final String versionUrl;
  final String completePath;
  final String siteUrl;
  final String key;
  final String shapeKey;
  final String stdKey;
  final String stdShapeKey;
  final String tuning;
  final int capo;
  final String composers;
  final bool isVerified;
  final bool blocked;
  final String reason;
  final List<UserChordDto>? chords;
  final UserVersionDataSongDto song;
  final UserVersionDataArtistDto? artist;
  final UserVersionDataVideoLessonDto? videoLesson;
  final List<UserContributorDto>? contributors;
  final List<UserInstrumentVersionsDto>? songsDetail;

  const UserVersionDataDto({
    required this.localId,
    required this.versionId,
    required this.songbookVersionId,
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
    this.chords,
    required this.song,
    this.artist,
    this.videoLesson,
    this.contributors,
    this.songsDetail,
  });

  UserVersionDataDto.fromDomain(VersionData versionData, int versionId)
      : this(
          localId: versionData.localId ?? Isar.autoIncrement,
          versionId: versionData.versionId,
          songbookVersionId: versionId,
          type: versionData.type,
          content: versionData.content,
          label: versionData.label,
          versionUrl: versionData.versionUrl,
          completePath: versionData.completePath,
          siteUrl: versionData.siteUrl,
          key: versionData.key,
          shapeKey: versionData.shapeKey,
          stdKey: versionData.stdKey,
          stdShapeKey: versionData.stdShapeKey,
          tuning: versionData.tuning,
          capo: versionData.capo,
          composers: versionData.composers,
          isVerified: versionData.isVerified,
          blocked: versionData.blocked,
          reason: versionData.reason,
          chords: versionData.chords?.map(UserChordDto.fromDomain).toList(),
          song: UserVersionDataSongDto.fromDomain(versionData.song),
          artist: versionData.artist != null ? UserVersionDataArtistDto.fromDomain(versionData.artist!) : null,
          videoLesson: versionData.videoLesson != null
              ? UserVersionDataVideoLessonDto.fromDomain(versionData.videoLesson!)
              : null,
          contributors: versionData.contributors?.map(UserContributorDto.fromDomain).toList(),
          songsDetail: versionData.instrumentVersions?.map(UserInstrumentVersionsDto.fromDomain).toList(),
        );

  @override
  @ignore
  List<Object?> get props => [
        versionId,
        localId,
        songbookVersionId,
        type,
        content,
        versionUrl,
        shapeKey,
        stdKey,
        stdShapeKey,
        tuning,
        capo,
        key
      ];
}
