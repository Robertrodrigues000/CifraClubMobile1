import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/domain/version/models/contributor.dart';
import 'package:cifraclub/domain/version/models/music.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/models/version_data_songs_detail.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:equatable/equatable.dart';

class VersionData extends Equatable {
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
  final List<Chord>? chords;
  final Music music;
  final Artist? artist;
  final VersionDataVideoLesson? videoLesson;
  final List<Contributor>? contributors;
  final List<VersionDataSongsDetail>? songsDetail;

  const VersionData({
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
    this.chords,
    required this.music,
    this.artist,
    this.videoLesson,
    this.contributors,
    this.songsDetail,
  });

  Version toVersion() => Version(
        songId: music.id,
        versionId: id,
        type: type,
        name: music.name,
        songUrl: url,
        artist: artist!,
        capo: capo,
        tuning: tuning,
        tone: key,
        stdTone: stdKey,
      );

  @override
  List<Object?> get props => [
        id,
        type,
        status,
        content,
        label,
        versionUrl,
        instrumentUrl,
        hits,
        url,
        siteUrl,
        youtubeId,
        key,
        shapeKey,
        stdKey,
        stdShapeKey,
        tuning,
        capo,
        level,
        font,
        composers,
        verified,
        blocked
      ];
}
