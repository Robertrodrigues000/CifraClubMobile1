import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/use_cases/get_filtered_artist_songs.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when getFilteredArtistSongs is called", () {
    test('if filter is bass should return songs with that instrument', () async {
      final songs = [
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 1,
          drums: 0,
          harmonica: 0,
          guitar: 0,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 0,
          drums: 3,
          harmonica: 0,
          guitar: 4,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
      ];
      final getFilteredArtistSongs = GetFilteredArtistSongs();

      final filteredSongs = await getFilteredArtistSongs(songs, Instrument.bass);

      expect(filteredSongs.length, 1);
      expect(filteredSongs.first.bass > 0, true);
    });

    test('if filter is drums should return songs with that instrument', () async {
      final songs = [
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 0,
          drums: 4,
          harmonica: 2,
          guitar: 0,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 4,
          drums: 0,
          harmonica: 0,
          guitar: 4,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
      ];
      final getFilteredArtistSongs = GetFilteredArtistSongs();

      final filteredSongs = await getFilteredArtistSongs(songs, Instrument.drums);

      expect(filteredSongs.length, 1);
      expect(filteredSongs.first.drums > 0, true);
    });

    test('if filter is harmonica should return songs with that instrument', () async {
      final songs = [
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 1,
          drums: 5,
          harmonica: 0,
          guitar: 0,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 0,
          drums: 0,
          harmonica: 2,
          guitar: 4,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
      ];
      final getFilteredArtistSongs = GetFilteredArtistSongs();

      final filteredSongs = await getFilteredArtistSongs(songs, Instrument.harmonica);

      expect(filteredSongs.length, 1);
      expect(filteredSongs.first.harmonica > 0, true);
    });

    test('if filter is cifra instrumet should return songs with those instruments', () async {
      final songs = [
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 1,
          drums: 4,
          harmonica: 1,
          guitar: 2,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 0,
          drums: 0,
          harmonica: 0,
          guitar: 4,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 0,
          drums: 2,
          harmonica: 0,
          guitar: 0,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 3,
          drums: 2,
          harmonica: 1,
          guitar: 0,
          guitarpro: 0,
          name: faker.address.streetName(),
          sheet: faker.randomGenerator.integer(10),
          url: faker.internet.httpsUrl(),
          verified: faker.randomGenerator.boolean(),
          videoLessons: faker.randomGenerator.integer(10),
          videoLessonsInstruments: const [],
        ),
      ];
      final getFilteredArtistSongs = GetFilteredArtistSongs();

      final filteredSongs = await getFilteredArtistSongs(songs, Instrument.cavaco);

      expect(filteredSongs.length, 2);
      expect(filteredSongs.every((element) => element.guitar > 0), true);
    });
  });
}
