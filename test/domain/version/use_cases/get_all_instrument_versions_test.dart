import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/domain/version/use_cases/get_all_instrument_versions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/version/models/instrument_version_mock.dart';

void main() {
  test(
      "When have guitar instrument should complete array with other string instruments and order by Instrument enum order",
      () {
    final instrumentVersions = [
      (instrument: Instrument.bass, versions: List<InstrumentVersion>.empty()),
      (instrument: Instrument.harmonica, versions: List<InstrumentVersion>.empty()),
      (instrument: Instrument.drums, versions: List<InstrumentVersion>.empty()),
      (instrument: Instrument.guitar, versions: List<InstrumentVersion>.empty()),
    ];

    final result = GetAllInstrumentVersions()(instrumentVersions);

    expect(result.length, 8);

    for (var i = 0; i < result.length; i++) {
      expect(result[i].instrument, Instrument.values[i]);
    }
  });

  test("When have guitar instrument should complete array and versions have to be equal than guitar versions", () {
    final versions = [getFakeInstrumentVersion(), getFakeInstrumentVersion()];
    final instrumentVersions = [
      (instrument: Instrument.guitar, versions: versions),
    ];

    final result = GetAllInstrumentVersions()(instrumentVersions);

    expect(result.length, 5);

    for (var i = 0; i < result.length; i++) {
      if (i == 0) {
        expect(result[i].versions, versions);
      } else {
        expect(result[i].versions.first.id, versions.first.id);
        expect(result[i].versions.first.isVerified, versions.first.isVerified);
        expect(result[i].versions.first.versionName, versions.first.versionName);
        expect(result[i].versions.first.versionUrl, versions.first.versionUrl);
        expect(result[i].versions.first.videoLesson, isNull);
        expect(result[i].versions.last.id, versions.last.id);
        expect(result[i].versions.last.isVerified, versions.last.isVerified);
        expect(result[i].versions.last.versionName, versions.last.versionName);
        expect(result[i].versions.last.versionUrl, versions.last.versionUrl);
        expect(result[i].versions.last.videoLesson, isNull);
      }
    }
  });

  test("When haven't guitar instrument should return original array", () {
    final versions = [getFakeInstrumentVersion(), getFakeInstrumentVersion()];
    final instrumentVersions = [
      (instrument: Instrument.bass, versions: versions),
    ];

    final result = GetAllInstrumentVersions()(instrumentVersions);

    expect(result.length, 1);
  });
}
