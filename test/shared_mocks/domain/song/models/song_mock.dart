import 'package:cifraclub/domain/song/models/song.dart';
import 'package:faker/faker.dart';

import '../../artist/models/artist_mock.dart';

Song getFakeSong() {
  return Song(
    id: faker.randomGenerator.integer(1000),
    name: faker.address.streetName(),
    url: faker.internet.httpsUrl(),
    artist: getFakeArtist(),
    isVerified: false,
  );
}
