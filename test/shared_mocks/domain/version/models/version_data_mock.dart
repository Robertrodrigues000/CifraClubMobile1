import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';
import 'instrument_version_mock.dart';
import 'music_mock.dart';

VersionData getFakeVersionData({
  List<({Instrument instrument, List<InstrumentVersion> versions})>? instrumentVersions,
}) {
  final label = faker.food.restaurant();
  return VersionData(
    versionId: faker.randomGenerator.integer(100),
    instrument: Instrument.bass,
    content: faker.food.restaurant(),
    versionName: label,
    versionUrl: faker.food.restaurant(),
    completePath: faker.food.restaurant(),
    siteUrl: faker.food.restaurant(),
    key: faker.food.restaurant(),
    shapeKey: faker.food.restaurant(),
    stdKey: faker.food.restaurant(),
    stdShapeKey: faker.food.restaurant(),
    tuning: faker.food.restaurant(),
    capo: faker.randomGenerator.integer(100),
    composers: faker.food.restaurant(),
    isVerified: faker.randomGenerator.boolean(),
    blocked: faker.randomGenerator.boolean(),
    reason: faker.food.restaurant(),
    instrumentVersions: instrumentVersions ??
        [
          (versions: [getFakeInstrumentVersion()], instrument: Instrument.bass)
        ],
    song: getFakeSong(),
    artist: getFakeArtist(),
  );
}
