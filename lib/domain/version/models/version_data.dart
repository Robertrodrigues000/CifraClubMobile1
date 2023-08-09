import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/domain/version/models/contributor.dart';
import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/models/instrument_versions.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:equatable/equatable.dart';

class VersionData extends Equatable {
  final int? localId;
  final int versionId;
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
  final List<Chord>? chords;
  final VersionDataSong song;
  final Artist? artist;
  final VersionDataVideoLesson? videoLesson;
  final List<Contributor>? contributors;
  final List<InstrumentVersions>? instrumentVersions;

  const VersionData({
    this.localId,
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
    this.chords,
    required this.song,
    this.artist,
    this.videoLesson,
    this.contributors,
    this.instrumentVersions,
  });

  // coverage:ignore-start
  Version toVersion(int versionId) => Version(
        remoteDatabaseID: versionId,
        songId: song.songId,
        versionId: versionId,
        type: type,
        name: song.name,
        songUrl: completePath,
        artist: artist!,
        capo: capo,
        tuning: tuning,
        tone: key,
        stdTone: stdKey,
        order: 0,
      );

  @override
  List<Object?> get props => [
        versionId,
        type,
        content,
        label,
        versionUrl,
        completePath,
        siteUrl,
        shapeKey,
        stdKey,
        stdShapeKey,
        tuning,
        capo,
        isVerified,
        blocked
      ];
  // coverage:ignore-end
}
