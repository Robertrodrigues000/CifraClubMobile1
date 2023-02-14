import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/search/models/artist_search.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when `toDomain` is called", () {
    test("Should correctly convert to Artist", () async {
      const searchDto = SearchDto(idSong: null, tipo: "1", txt: "Lifehouse", url: null, idArtist: 2843, art: "Lifehouse", dns: "lifehouse", img: "3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c-tb.jpg");
      final search = searchDto.toDomain();

      expect(search, isA<ArtistSearch>());
      search as ArtistSearch;

      expect(search.id, searchDto.idArtist);
      expect(search.url, searchDto.dns);
      expect(search.imageUrl, searchDto.img);
      expect(search.name, searchDto.art);
    });

    test("Should correctly convert to Song", () async {
      const searchDto =
          SearchDto(idSong: 27161, tipo: "2", txt: "You And Me", url: "you-and-me", idArtist: 2843, art: "Lifehouse", dns: "lifehouse", img: "3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c-tb.jpg");
      final search = searchDto.toDomain();

      expect(search, isA<SongSearch>());
      search as SongSearch;

      expect(search.songId, searchDto.idSong);
      expect(search.songName, searchDto.txt);
      expect(search.songUrl, searchDto.url);
      expect(search.artistId, searchDto.idArtist);
      expect(search.artistName, searchDto.art);
      expect(search.artistUrl, searchDto.dns);
      expect(search.artistImage, searchDto.img);
    });
  });
}
