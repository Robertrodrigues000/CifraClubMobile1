import 'package:cifraclub/domain/artist/use_cases/get_artist_songs_filtered_by_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';

void main() {
  final songs = [
    getFakeArtistSong(name: "aaa"),
    getFakeArtistSong(name: "aab"),
    getFakeArtistSong(name: "ccc"),
    getFakeArtistSong(name: "CcC")
  ];
  test('When the searchString is empty, the usecase should return all the songs', () async {
    var getArtistSongsFilteredBySearch = GetArtistSongsFilteredBySearch();
    var result = getArtistSongsFilteredBySearch(songs: songs, searchString: "");
    expect(listEquals(result.$1, songs), isTrue);
    expect(listEquals(result.$2, ["1", "2", "3", "4"]), isTrue);

    result = getArtistSongsFilteredBySearch(songs: songs, searchString: " ");
    expect(listEquals(result.$1, songs), isTrue);
    expect(listEquals(result.$2, ["1", "2", "3", "4"]), isTrue);
  });

  test('When the searchString is not empty, the usecase should return songs filtered correctly', () async {
    var getArtistSongsFilteredBySearch = GetArtistSongsFilteredBySearch();

    var result = getArtistSongsFilteredBySearch(songs: songs, searchString: "a");
    expect(listEquals(result.$1, [songs[0], songs[1]]), isTrue);
    expect(
        listEquals(result.$2, [
          "1",
          "2",
        ]),
        isTrue);

    result = getArtistSongsFilteredBySearch(songs: songs, searchString: " a");
    expect(listEquals(result.$1, [songs[0], songs[1]]), isTrue);
    expect(
        listEquals(result.$2, [
          "1",
          "2",
        ]),
        isTrue);

    result = getArtistSongsFilteredBySearch(songs: songs, searchString: " a ");
    expect(listEquals(result.$1, [songs[0], songs[1]]), isTrue);
    expect(
        listEquals(result.$2, [
          "1",
          "2",
        ]),
        isTrue);

    result = getArtistSongsFilteredBySearch(songs: songs, searchString: "ab");
    expect(listEquals(result.$1, [songs[1]]), isTrue);
    expect(
        listEquals(result.$2, [
          "2",
        ]),
        isTrue);

    result = getArtistSongsFilteredBySearch(songs: songs, searchString: "cc");
    expect(listEquals(result.$1, [songs[2], songs[3]]), isTrue);
    expect(listEquals(result.$2, ["3", "4"]), isTrue);
  });
}
