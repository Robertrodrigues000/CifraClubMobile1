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
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'user_version_data_dto.g.dart';

@Collection(inheritance: false)
class UserVersionDataDto extends Equatable {
  final Id localDatabaseId;
  @Index(composite: [CompositeIndex("songbookId")], unique: true, replace: true)
  final int versionLocalDatabaseId;
  final int versionId;
  @Index()
  final int songbookId;
  @enumerated
  final Instrument instrument;
  final String content;
  final String versionName;
  final String versionUrl;
  final String completePath;
  final String siteUrl;
  final String? key;
  final String? shapeKey;
  final String? stdKey;
  final String? stdShapeKey;
  final String? tuning;
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
  final List<UserInstrumentVersionsDto>? instrumentVersions;

  const UserVersionDataDto({
    required this.localDatabaseId,
    required this.songbookId,
    required this.versionLocalDatabaseId,
    required this.versionId,
    required this.instrument,
    required this.content,
    required this.versionName,
    required this.versionUrl,
    required this.completePath,
    required this.siteUrl,
    required this.key,
    this.shapeKey,
    this.stdKey,
    this.stdShapeKey,
    this.tuning,
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
    this.instrumentVersions,
  });

  UserVersionDataDto.fromDomain({
    required VersionData versionData,
    required int versionLocalDatabaseId,
    required int songbookId,
  }) : this(
          localDatabaseId: versionData.localDatabaseId ?? Isar.autoIncrement,
          versionLocalDatabaseId: versionLocalDatabaseId,
          songbookId: songbookId,
          versionId: versionData.versionId,
          instrument: versionData.instrument,
          content: versionData.content,
          versionName: versionData.versionName,
          versionUrl: versionData.versionUrl,
          completePath: versionData.completePath,
          siteUrl: versionData.siteUrl,
          key: versionData.key,
          shapeKey: versionData.shapeKey,
          stdKey: versionData.stdKey,
          stdShapeKey: versionData.stdShapeKey,
          tuning: versionData.tuning,
          capo: versionData.capo.capoId,
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
          instrumentVersions: versionData.instrumentVersions?.map(UserInstrumentVersionsDto.fromDomain).toList(),
        );

  @override
  @ignore
  List<Object?> get props => [
        localDatabaseId,
        versionId,
        versionLocalDatabaseId,
        songbookId,
        song.songId,
        instrument,
        shapeKey,
        stdKey,
        stdShapeKey,
        tuning,
        capo,
        key
      ];
}
