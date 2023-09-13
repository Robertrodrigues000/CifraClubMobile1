import 'package:cifraclub/domain/version/models/version.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/version/models/version_data_mock.dart';

void main() {
  test("When fromVersionData is called", () {
    final versionData = getFakeVersionData();
    final version = Version.fromVersionData(versionData);

    expect(version.localDatabaseId, versionData.localDatabaseId);
    expect(version.songId, versionData.song.songId);
    expect(version.versionId, versionData.versionId);
    expect(version.instrument, versionData.instrument);
    expect(version.name, versionData.song.name);
    expect(version.songUrl, versionData.completePath);
    expect(version.artist, versionData.artist);
    expect(version.capo, versionData.capo);
    expect(version.tuning, versionData.tuning);
    expect(version.key, versionData.key);
    expect(version.stdKey, versionData.stdKey);
    expect(version.order, 0);
  });
}
