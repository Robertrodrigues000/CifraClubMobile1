import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:faker/faker.dart';

SongbookVersionInput getFakeSongbookVersionInput() => SongbookVersionInput(
      artistUrl: faker.animal.name(),
      songUrl: faker.animal.name(),
      versionId: faker.randomGenerator.integer(1000),
      capo: faker.randomGenerator.integer(1000),
      id: faker.randomGenerator.integer(1000),
      instrument: faker.animal.name(),
      tone: faker.animal.name(),
      tuning: faker.animal.name(),
      type: faker.randomGenerator.integer(1000),
      versionLabel: faker.animal.name(),
    );
