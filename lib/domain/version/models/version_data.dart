import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/domain/version/models/contributor.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'version_data.g.dart';

@CopyWith()
class VersionData extends Equatable {
  final int? localDatabaseId;
  final int? songbookId;
  final int? versionLocalDatabaseId;
  final int versionId;
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
  final List<Chord>? chords;
  final VersionDataSong song;
  final Artist? artist;
  final VersionDataVideoLesson? videoLesson;
  final List<Contributor>? contributors;
  final List<({Instrument instrument, List<InstrumentVersion> versions})>? instrumentVersions;

  const VersionData({
    this.songbookId,
    this.localDatabaseId,
    this.versionLocalDatabaseId,
    required this.versionId,
    required this.instrument,
    required this.content,
    required this.versionName,
    required this.versionUrl,
    required this.completePath,
    required this.siteUrl,
    this.key,
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

  // coverage:ignore-start
  @override
  List<Object?> get props => [
        localDatabaseId,
        versionLocalDatabaseId,
        songbookId,
        versionId,
        song.songId,
        instrument,
        shapeKey,
        stdKey,
        stdShapeKey,
        tuning,
        capo,
        isVerified
      ];
  // coverage:ignore-end
}
