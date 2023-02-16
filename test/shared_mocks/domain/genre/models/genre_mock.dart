import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:faker/faker.dart';

Genre getFakeGenre() {
  return Genre(
    name: faker.address.streetName(),
    url: faker.internet.httpsUrl(),
  );
}
