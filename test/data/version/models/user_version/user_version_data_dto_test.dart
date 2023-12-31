import 'package:cifraclub/data/version/models/user_version/user_version_data_dto.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../../shared_mocks/domain/version/models/music_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_data_video_lesson.dart';

void main() {
  test("When call 'fromDomain'", () {
    final versionData = VersionData(
      versionId: 1,
      instrument: Instrument.bass,
      content: "Content",
      versionName: "Label",
      versionUrl: "https://example.com/version.mp3",
      completePath: "https://example.com/song.json",
      siteUrl: "https://example.com/site.json",
      key: "Key",
      shapeKey: "Shape Key",
      stdKey: "Std Key",
      stdShapeKey: "Std Shape Key",
      tuning: Tuning.c,
      capo: Capo.capo10,
      composers: "Composers",
      isVerified: true,
      blocked: false,
      reason: "Reason",
      song: getFakeSong(),
      videoLesson: getFakeVersionDataVideoLesson(),
    );

    final userVersionDataDto =
        UserVersionDataDto.fromDomain(versionData: versionData, versionLocalDatabaseId: 11, songbookId: 1);

    expect(userVersionDataDto.localDatabaseId, Isar.autoIncrement);
    expect(userVersionDataDto.versionId, 1);
    expect(userVersionDataDto.versionLocalDatabaseId, 11);
    expect(userVersionDataDto.instrument, Instrument.bass);
    expect(userVersionDataDto.content, "Content");
    expect(userVersionDataDto.versionName, "Label");
    expect(userVersionDataDto.versionUrl, "https://example.com/version.mp3");
    expect(userVersionDataDto.completePath, "https://example.com/song.json");
    expect(userVersionDataDto.siteUrl, "https://example.com/site.json");
    expect(userVersionDataDto.key, "Key");
    expect(userVersionDataDto.shapeKey, "Shape Key");
    expect(userVersionDataDto.stdKey, "Std Key");
    expect(userVersionDataDto.stdShapeKey, "Std Shape Key");
    expect(userVersionDataDto.tuning, Tuning.c.value);
    expect(userVersionDataDto.capo, Capo.capo10.capoId);
    expect(userVersionDataDto.composers, "Composers");
    expect(userVersionDataDto.isVerified, true);
    expect(userVersionDataDto.blocked, false);
    expect(userVersionDataDto.reason, "Reason");
    expect(userVersionDataDto.songbookId, 1);
  });
}
