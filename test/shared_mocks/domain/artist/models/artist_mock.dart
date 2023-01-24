import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:faker/faker.dart';

import '../../genre/models/genre_mock.dart';
import 'artist_image_mock.dart';

Artist getFakeArtist() {
  return Artist(
    id: faker.randomGenerator.integer(1000),
    url: faker.internet.httpsUrl(),
    name: faker.address.streetName(),
    image: getFakeArtistImage(),
    genre: getFakeGenre(),
  );
}
