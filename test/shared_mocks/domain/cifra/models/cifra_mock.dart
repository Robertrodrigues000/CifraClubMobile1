import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:faker/faker.dart';

Cifra getFakeCifra() {
  return Cifra(
      id: faker.randomGenerator.integer(100),
      name: faker.animal.name(),
      songUrl: faker.address.city(),
      tone: faker.vehicle.model(),
      type: faker.randomGenerator.integer(4));
}
