import 'package:cifraclub/domain/song/models/local_song.dart';
import 'package:faker/faker.dart';

LocalSong getFakeLocalSong() => LocalSong(
      artistName: faker.animal.name(),
      duration: faker.randomGenerator.integer(1000),
      songName: faker.company.name(),
      albumId: faker.randomGenerator.integer(1000).toString(),
      path: faker.internet.ipv4Address(),
    );
