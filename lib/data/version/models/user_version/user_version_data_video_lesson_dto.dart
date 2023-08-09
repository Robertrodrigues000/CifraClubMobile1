import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:isar/isar.dart';

part 'user_version_data_video_lesson_dto.g.dart';

@embedded
class UserVersionDataVideoLessonDto {
  late final int id;
  late final String youtubeId;
  late final String title;
  late final String thumb;

  UserVersionDataVideoLessonDto(); // coverage:ignore-line

  UserVersionDataVideoLessonDto.fromDomain(VersionDataVideoLesson videoLesson) {
    id = videoLesson.id;
    youtubeId = videoLesson.youtubeId;
    title = videoLesson.title;
    thumb = videoLesson.thumb;
  }
}
