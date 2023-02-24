import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:faker/faker.dart';

Songbook getFakeSongbook() => Songbook(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
    );
