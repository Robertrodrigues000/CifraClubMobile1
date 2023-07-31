import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';

void main() {
  group("when getAlphabeticalPrefixesList is called", () {
    test("should return list of prefixes ordered alphabetically", () async {
      final songs = [
        getFakeArtistSong(name: "Coração cigano"),
        getFakeArtistSong(name: "A Bússola"),
        getFakeArtistSong(name: "Chocolate"),
        getFakeArtistSong(name: "Amar não é pecado"),
        getFakeArtistSong(name: "Adrenalina"),
      ];

      final getAlphabeticalPrefixesList = GetAlphabeticalPrefixesList();
      final prefixes = getAlphabeticalPrefixesList(songs);

      expect(prefixes.length, songs.length);
      expect(prefixes, ["A", "", "", "C", ""]);
    });

    test("and a song name starts with number, prefix should be #", () async {
      final songs = [
        getFakeArtistSong(name: "1 Billion views"),
        getFakeArtistSong(name: "24/7"),
        getFakeArtistSong(name: "Candy"),
      ];

      final getAlphabeticalPrefixesList = GetAlphabeticalPrefixesList();
      final prefixes = getAlphabeticalPrefixesList(songs);

      expect(prefixes.length, songs.length);
      expect(prefixes, ["#", "", "C"]);
    });

    test("and a song name starts with accented letter, should ignore accent", () async {
      final songs = [
        getFakeArtistSong(name: "É"),
        getFakeArtistSong(name: "Efêmera"),
        getFakeArtistSong(name: "Às vezes"),
      ];

      final getAlphabeticalPrefixesList = GetAlphabeticalPrefixesList();
      final prefixes = getAlphabeticalPrefixesList(songs);

      expect(prefixes.length, songs.length);
      expect(prefixes, ["A", "E", ""]);
    });
  });
}
