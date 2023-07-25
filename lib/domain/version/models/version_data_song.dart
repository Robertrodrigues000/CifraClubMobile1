import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';

class VersionDataSong {
  final int id;
  final String label;
  final int hits;
  final String versionUrl;
  final String instrumentUrl;
  final VersionDataVideoLesson? videoLesson;
  final int level;
  final String url;
  final bool verified;

  VersionDataSong({
    required this.id,
    required this.label,
    required this.hits,
    required this.versionUrl,
    required this.instrumentUrl,
    this.videoLesson,
    required this.level,
    required this.url,
    required this.verified,
  });
}
