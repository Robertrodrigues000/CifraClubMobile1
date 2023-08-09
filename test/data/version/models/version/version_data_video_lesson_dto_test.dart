import 'package:cifraclub/data/version/models/version/version_data_video_lesson_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When `toDomain` is called should convert correctly", () {
    final videoLessonDto = VersionDataVideoLessonDto(
      id: 1,
      youtubeId: "youtube",
      title: "marilia mendonça",
      thumb: "marilia mendonça foto",
    );
    final version = videoLessonDto.toDomain();

    expect(version.id, 1);
    expect(version.youtubeId, "youtube");
    expect(version.title, "marilia mendonça");
    expect(version.thumb, "marilia mendonça foto");
  });
}
