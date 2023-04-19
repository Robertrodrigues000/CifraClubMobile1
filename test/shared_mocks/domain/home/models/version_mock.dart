import 'package:cifraclub/domain/home/models/version.dart';
import 'package:faker/faker.dart';

Version getFakeVersion() => Version(
      id: faker.randomGenerator.integer(1000),
      type: faker.randomGenerator.integer(10),
      label: faker.animal.name(),
    );
