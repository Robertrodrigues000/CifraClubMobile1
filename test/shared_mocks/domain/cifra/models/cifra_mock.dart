import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';

Cifra getFakeCifra() {
  return Cifra(
    localDatabaseID: faker.randomGenerator.integer(100),
    name: faker.animal.name(),
    songUrl: faker.address.city(),
    tone: faker.vehicle.model(),
    type: faker.randomGenerator.integer(4),
    songId: faker.randomGenerator.integer(100),
    capo: faker.randomGenerator.integer(5),
    stdTone: faker.food.restaurant(),
    tuning: faker.food.restaurant(),
    artist: getFakeArtist(),
    versionId: faker.randomGenerator.integer(10000),
  );
}
