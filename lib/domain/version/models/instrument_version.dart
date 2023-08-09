import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';

class InstrumentVersion {
  final int id;
  final String label;
  final String versionUrl;
  final VersionDataVideoLesson? videoLesson;
  final String completePath;
  final bool isVerified;

  InstrumentVersion({
    required this.id,
    required this.label,
    required this.versionUrl,
    this.videoLesson,
    required this.completePath,
    required this.isVerified,
  });
}
