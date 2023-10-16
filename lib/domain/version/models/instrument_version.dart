import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'instrument_version.g.dart';

@CopyWith()
class InstrumentVersion {
  final int id;
  final String versionName;
  final String versionUrl;
  final VersionDataVideoLesson? videoLesson;
  final String completePath;
  final bool isVerified;

  InstrumentVersion({
    required this.id,
    required this.versionName,
    required this.versionUrl,
    this.videoLesson,
    required this.completePath,
    required this.isVerified,
  });
}
