import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:faker/faker.dart';

ArtistSong getFakeArtistSong() {
  return ArtistSong(
    id: faker.randomGenerator.integer(10),
    lyrics: faker.randomGenerator.integer(10),
    lyricsId: faker.randomGenerator.integer(10),
    bass: faker.randomGenerator.integer(10),
    drums: faker.randomGenerator.integer(10),
    harmonica: faker.randomGenerator.integer(10),
    guitar: faker.randomGenerator.integer(10),
    guitarpro: faker.randomGenerator.integer(10),
    name: faker.address.streetName(),
    sheet: faker.randomGenerator.integer(10),
    url: faker.internet.httpsUrl(),
    verified: faker.randomGenerator.integer(1, min: 0) == 0,
    videoLessons: faker.randomGenerator.integer(10),
    videoLessonsInstruments: const [],
  );
}
