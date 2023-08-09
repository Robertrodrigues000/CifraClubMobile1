import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:faker/faker.dart';

VersionDataSong getFakeSong() => VersionDataSong(
      songId: faker.randomGenerator.integer(100),
      lyricsId: faker.randomGenerator.integer(100),
      name: faker.food.restaurant(),
      url: faker.food.restaurant(),
      description: faker.food.restaurant(),
    );
