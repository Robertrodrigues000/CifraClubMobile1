import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:faker/faker.dart';

Songbook getFakeSongbook({ListType listType = ListType.user, String? name, bool? isPublic, List<String>? preview}) =>
    Songbook(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: name ?? faker.animal.name(),
      isPublic: isPublic ?? faker.randomGenerator.boolean(),
      type: listType,
      totalSongs: faker.randomGenerator.integer(10),
      preview: preview ?? [faker.animal.name()],
    );
