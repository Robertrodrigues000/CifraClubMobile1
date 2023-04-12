import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:faker/faker.dart';

Songbook getFakeSongbook() => Songbook(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      isPublic: false,
      type: ListType.user,
      totalSongs: faker.randomGenerator.integer(10),
    );
