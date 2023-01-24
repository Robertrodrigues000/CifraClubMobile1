import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:faker/faker.dart';

Genre getFakeGenre() {
  return Genre(
    id: faker.randomGenerator.integer(1000),
    name: faker.address.streetName(),
    url: faker.internet.httpsUrl(),
  );
}
