import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:faker/faker.dart';

ArtistSong getFakeArtistSong({String? name, int? bass, int? drums, int? harmonica, int? guitar, int? guitarpro}) {
  return ArtistSong(
    id: faker.randomGenerator.integer(10),
    lyrics: faker.randomGenerator.integer(10),
    lyricsId: faker.randomGenerator.integer(10),
    bass: bass ?? faker.randomGenerator.integer(10),
    drums: drums ?? faker.randomGenerator.integer(10),
    harmonica: harmonica ?? faker.randomGenerator.integer(10),
    guitar: guitar ?? faker.randomGenerator.integer(10),
    guitarpro: guitarpro ?? faker.randomGenerator.integer(10),
    name: name ?? faker.address.streetName(),
    sheet: faker.randomGenerator.integer(10),
    url: faker.internet.httpsUrl(),
    verified: faker.randomGenerator.integer(1, min: 0) == 0,
    videoLessons: faker.randomGenerator.integer(10),
    videoLessonsInstruments: const [],
  );
}
