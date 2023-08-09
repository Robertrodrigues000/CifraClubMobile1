import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:faker/faker.dart';

import 'music_mock.dart';

VersionData getFakeVersionData() {
  return VersionData(
      versionId: faker.randomGenerator.integer(100),
      type: faker.randomGenerator.integer(100),
      content: faker.food.restaurant(),
      label: faker.food.restaurant(),
      versionUrl: faker.food.restaurant(),
      completePath: faker.food.restaurant(),
      siteUrl: faker.food.restaurant(),
      key: faker.food.restaurant(),
      shapeKey: faker.food.restaurant(),
      stdKey: faker.food.restaurant(),
      stdShapeKey: faker.food.restaurant(),
      tuning: faker.food.restaurant(),
      capo: faker.randomGenerator.integer(100),
      composers: faker.food.restaurant(),
      isVerified: faker.randomGenerator.boolean(),
      blocked: faker.randomGenerator.boolean(),
      reason: faker.food.restaurant(),
      song: getFakeSong());
}
