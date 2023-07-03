import 'package:cifraclub/domain/version/models/version.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';

Version getFakeVersion({int? versionId}) {
  return Version(
    localDatabaseID: faker.randomGenerator.integer(100),
    remoteDatabaseID: faker.randomGenerator.integer(100),
    name: faker.animal.name(),
    songUrl: faker.address.city(),
    tone: faker.vehicle.model(),
    type: faker.randomGenerator.integer(4),
    songId: faker.randomGenerator.integer(100),
    capo: faker.randomGenerator.integer(5),
    stdTone: faker.food.restaurant(),
    tuning: faker.food.restaurant(),
    artist: getFakeArtist(),
    versionId: versionId ?? faker.randomGenerator.integer(10000),
  );
}
