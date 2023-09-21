import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/artist_search.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/models/search_models/songbook_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when `toDomain` is called", () {
    test("Should correctly convert to Artist", () async {
      const searchDto = SearchDto(
        songId: null,
        type: "1",
        txt: "Lifehouse",
        url: null,
        artistId: 2843,
        artist: "Lifehouse",
        artistUrl: "lifehouse",
        imgm: "https://akamai.sscdn.co/letras/250x250/fotos/3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c-tb.jpg",
        albumUrl: null,
        songbookId: null,
        userId: null,
        songbookName: null,
        userName: null,
        totalSongs: null,
        imgsm: null,
        isVerified: null,
      );
      final search = searchDto.toDomain();

      expect(search, isA<ArtistSearch>());
      search as ArtistSearch;

      expect(search.id, searchDto.artistId);
      expect(search.url, searchDto.artistUrl);
      expect(search.imageUrl, searchDto.imgm);
      expect(search.name, searchDto.artist);
    });

    test("Should correctly convert to Song", () async {
      const searchDto = SearchDto(
        songId: 27161,
        type: "2",
        txt: "You And Me",
        url: "you-and-me",
        artistId: 2843,
        artist: "Lifehouse",
        artistUrl: "lifehouse",
        imgm: "https://akamai.sscdn.co/letras/250x250/fotos/3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c-tb.jpg",
        albumUrl: null,
        songbookId: null,
        userId: null,
        songbookName: null,
        userName: null,
        totalSongs: null,
        imgsm: null,
        isVerified: false,
      );
      final search = searchDto.toDomain();

      expect(search, isA<SongSearch>());
      search as SongSearch;

      expect(search.songId, searchDto.songId);
      expect(search.songName, searchDto.txt);
      expect(search.songUrl, searchDto.url);
      expect(search.artistId, searchDto.artistId);
      expect(search.artistName, searchDto.artist);
      expect(search.artistUrl, searchDto.artistUrl);
      expect(search.artistImage, searchDto.imgm);
    });

    test("Should correctly convert to Songbook", () async {
      const searchDto = SearchDto(
        songId: null,
        type: "5",
        txt: null,
        url: null,
        artistId: null,
        artist: null,
        artistUrl: null,
        imgm: null,
        albumUrl: null,
        songbookId: 326619,
        userId: "121234",
        songbookName: "As Melhores Romanticas",
        userName: "Alexsandro Da Silva Silva",
        totalSongs: 16,
        imgsm: [
          "https://akamai.sscdn.co/letras/50x50/fotos/8/d/d/f/8ddf6e506f44d81c4ade17c505972db3.jpg",
          "https://akamai.sscdn.co/letras/50x50/fotos/4/4/d/7/44d7e40e25e5a0925c72c55d4ba28bac.jpg",
          "https://akamai.sscdn.co/letras/50x50/fotos/d/8/0/0/d800149d2f947ad4d64f34668f8b20f6.jpg",
          "https://akamai.sscdn.co/letras/50x50/fotos/e/0/6/f/e06f967fb0d355592be4e7674fa31d26.jpg",
          "https://akamai.sscdn.co/letras/50x50/fotos/0/c/4/a/0c4a49c282428682af1176a18b7d364a.jpg"
        ],
        isVerified: null,
      );
      final search = searchDto.toDomain();

      expect(search, isA<SongbookSearch>());
      search as SongbookSearch;

      expect(search.songbookId, searchDto.songbookId);
      expect(search.songbookName, searchDto.songbookName);
      expect(search.userId, searchDto.userId);
      expect(search.userName, searchDto.userName);
      expect(search.totalSongs, searchDto.totalSongs);
      expect(search.songbookPreview, searchDto.imgsm);
    });

    test("Should correctly convert to Album", () async {
      const searchDto = SearchDto(
        songId: null,
        type: "6",
        txt: "As Melhores",
        url: null,
        artistId: 7034,
        artist: "Fagner",
        artistUrl: "fagner",
        imgm: "https://akamai.sscdn.co/letras/250x250/albuns/9/b/a/2/1865871689597967.jpg",
        albumUrl: "as-melhores-2001",
        songbookId: null,
        userId: null,
        songbookName: null,
        userName: null,
        totalSongs: null,
        imgsm: null,
        isVerified: null,
      );
      final search = searchDto.toDomain();

      expect(search, isA<AlbumSearch>());
      search as AlbumSearch;

      expect(search.albumName, searchDto.txt);
      expect(search.artistId, searchDto.artistId);
      expect(search.artistName, searchDto.artist);
      expect(search.artistUrl, searchDto.artistUrl);
      expect(search.albumCover, searchDto.imgm);
      expect(search.albumUrl, searchDto.albumUrl);
    });
  });
}
