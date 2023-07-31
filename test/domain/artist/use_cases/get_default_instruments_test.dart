import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when getDefaultInstruments is called", () {
    test('should return ordered instruments from songs', () async {
      final songs = [
        ArtistSong(
          id: faker.randomGenerator.integer(10),
          lyrics: faker.randomGenerator.integer(10),
          lyricsId: faker.randomGenerator.integer(10),
          bass: 1,
          drums: 4,
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
      ];
      final getDefaultInstruments = GetDefaultInstruments();

      final instruments = await getDefaultInstruments(songs);

      expect(instruments.length, 8);
      expect(instruments, Instrument.values);
    });
  });

  test('when songs has only bass and drums instruments should return in the correct order', () async {
    final songs = [
      ArtistSong(
        id: faker.randomGenerator.integer(10),
        lyrics: faker.randomGenerator.integer(10),
        lyricsId: faker.randomGenerator.integer(10),
        bass: 0,
        drums: 4,
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
        bass: 2,
        drums: 1,
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
    ];
    final getDefaultInstruments = GetDefaultInstruments();

    final instruments = await getDefaultInstruments(songs);

    expect(instruments.length, 2);
    expect(instruments.first, Instrument.bass);
    expect(instruments.last, Instrument.drums);
  });

  test('when songs has only guitar and bass instruments should return in the correct order', () async {
    final songs = [
      ArtistSong(
        id: faker.randomGenerator.integer(10),
        lyrics: faker.randomGenerator.integer(10),
        lyricsId: faker.randomGenerator.integer(10),
        bass: 1,
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
        drums: 0,
        harmonica: 0,
        guitar: 3,
        guitarpro: 0,
        name: faker.address.streetName(),
        sheet: faker.randomGenerator.integer(10),
        url: faker.internet.httpsUrl(),
        verified: faker.randomGenerator.boolean(),
        videoLessons: faker.randomGenerator.integer(10),
        videoLessonsInstruments: const [],
      ),
    ];
    final getDefaultInstruments = GetDefaultInstruments();

    final instruments = await getDefaultInstruments(songs);

    expect(instruments.length, 6);
    expect(instruments[0], Instrument.guitar);
    expect(instruments[1], Instrument.ukulele);
    expect(instruments[2], Instrument.keyboard);
    expect(instruments[3], Instrument.cavaco);
    expect(instruments[4], Instrument.violaCaipira);
    expect(instruments[5], Instrument.bass);
  });
}
