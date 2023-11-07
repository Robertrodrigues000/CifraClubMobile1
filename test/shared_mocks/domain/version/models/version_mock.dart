import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';

Version getFakeVersion(
    {int? versionId, String? name, int? remoteDatabaseId, int? localDatabaseId, int? order, DateTime? lastUpdate}) {
  return Version(
    localDatabaseId: localDatabaseId ?? faker.randomGenerator.integer(100),
    remoteDatabaseId: remoteDatabaseId ?? faker.randomGenerator.integer(100),
    lastUpdate: lastUpdate ?? DateTime.now(),
    name: name ?? faker.animal.name(),
    songUrl: faker.address.city(),
    key: faker.vehicle.model(),
    instrument: Instrument.bass,
    songId: faker.randomGenerator.integer(100),
    capo: Capo.getCapoById(faker.randomGenerator.integer(12)),
    stdKey: faker.food.restaurant(),
    tuning: Tuning.c,
    artist: getFakeArtist(),
    versionId: versionId ?? faker.randomGenerator.integer(10000),
    order: order ?? faker.randomGenerator.integer(10000),
  );
}
