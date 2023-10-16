import 'package:cifraclub/data/version/models/version/instrument_version_dto.dart';
import 'package:cifraclub/data/version/models/version/version_data_video_lesson_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/version/models/version_data_video_lesson.dart';

class _VersionDataVideoLessonDtoMock extends Mock implements VersionDataVideoLessonDto {}

void main() {
  test("When `toDomain` is called should convert correctly", () {
    final videoLesson = _VersionDataVideoLessonDtoMock();
    when(videoLesson.toDomain).thenReturn(getFakeVersionDataVideoLesson());

    final instrumentVersionDto = InstrumentVersionDto(
      versionId: 1,
      versionName: "label",
      versionUrl: "versionUrl",
      completePath: "url",
      isVerified: true,
      videoLesson: videoLesson,
    );
    final instrumentVersion = instrumentVersionDto.toDomain();

    verify(videoLesson.toDomain).called(1);
    expect(instrumentVersion.id, 1);
    expect(instrumentVersion.versionName, "label");
    expect(instrumentVersion.versionUrl, "versionUrl");
    expect(instrumentVersion.completePath, "url");
    expect(instrumentVersion.isVerified, true);
  });
}
