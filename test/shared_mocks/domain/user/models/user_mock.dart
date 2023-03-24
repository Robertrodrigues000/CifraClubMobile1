import 'package:cifraclub/domain/user/models/user.dart';
import 'package:faker/faker.dart';

User getFakeUser() {
  return User(
    name: faker.animal.name(),
    email: faker.internet.email(),
    avatarUrl: faker.image.image(random: true),
    city: faker.address.city(),
    stateInitials: faker.address.stateAbbreviation(),
    state: faker.address.state(),
    country: faker.address.country(),
    id: faker.randomGenerator.integer(1000),
  );
}
