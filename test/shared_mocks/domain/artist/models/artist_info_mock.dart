import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:faker/faker.dart';

ArtistInfo getFakeArtistInfo() => ArtistInfo(
      id: faker.randomGenerator.integer(1000),
      name: faker.address.streetName(),
      url: faker.internet.httpsUrl(),
      hitsCount: faker.randomGenerator.integer(1000),
      genre: Genre(
        name: faker.address.streetName(),
        url: faker.internet.httpsUrl(),
      ),
    );
