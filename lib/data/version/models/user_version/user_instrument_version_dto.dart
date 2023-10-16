import 'package:cifraclub/data/version/models/user_version/user_version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:isar/isar.dart';

part 'user_instrument_version_dto.g.dart';

@embedded
class UserInstrumentVersionDto {
  late final int id;
  late final String versionName;
  late final String versionUrl;
  late final UserVersionDataVideoLessonDto? videoLesson;
  late final String completePath;
  late final bool isVerified;

  UserInstrumentVersionDto(); // coverage:ignore-line

  UserInstrumentVersionDto.fromDomain(InstrumentVersion versionDataSong) {
    id = versionDataSong.id;
    versionName = versionDataSong.versionName;
    versionUrl = versionDataSong.versionUrl;
    videoLesson = versionDataSong.videoLesson != null
        ? UserVersionDataVideoLessonDto.fromDomain(versionDataSong.videoLesson!)
        : null;
    completePath = versionDataSong.completePath;
    isVerified = versionDataSong.isVerified;
  }
}
