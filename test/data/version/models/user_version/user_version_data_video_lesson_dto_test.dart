import 'package:cifraclub/data/version/models/user_version/user_version_data_video_lesson_dto.dart';
import 'package:cifraclub/domain/version/models/version_data_video_lesson.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final videoLesson = VersionDataVideoLesson(
      id: 1,
      youtubeId: "youtube_id",
      title: "Title",
      thumb: "thumb",
    );

    final userVersionDataVideoLessonDto = UserVersionDataVideoLessonDto.fromDomain(videoLesson);

    expect(userVersionDataVideoLessonDto.id, 1);
    expect(userVersionDataVideoLessonDto.youtubeId, "youtube_id");
    expect(userVersionDataVideoLessonDto.title, "Title");
    expect(userVersionDataVideoLessonDto.thumb, "thumb");
  });
}
