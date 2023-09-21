import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:faker/faker.dart';

Album getFakeAlbum() {
  return Album(
    artistName: faker.animal.name(),
    id: faker.randomGenerator.integer(100),
    artistUrl: faker.internet.httpUrl(),
    title: faker.animal.name(),
    albumUrl: faker.internet.httpUrl(),
    totalSongs: faker.randomGenerator.integer(10),
    releaseYear: faker.randomGenerator.integer(2023, min: 1800),
  );
}
