import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/artist_search.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/models/search_models/songbook_search.dart';
import 'package:faker/faker.dart';

ArtistSearch getFakeArtistSearch() => ArtistSearch(
      id: faker.randomGenerator.integer(1000),
      name: faker.address.person.name(),
      url: faker.address.person.firstName(),
      imageUrl: faker.image.image(),
    );

SongSearch getFakeSongSearch() => SongSearch(
      songId: faker.randomGenerator.integer(1000),
      songName: faker.address.person.lastName(),
      songUrl: faker.internet.httpsUrl(),
      artistId: faker.randomGenerator.integer(1000),
      artistName: faker.address.person.name(),
      artistUrl: faker.address.person.firstName(),
      artistImage: faker.image.image(),
      isVerified: false,
    );

AlbumSearch getFakeAlbumSearch() => AlbumSearch(
      albumName: faker.address.person.lastName(),
      albumUrl: faker.internet.httpsUrl(),
      artistId: faker.randomGenerator.integer(1000),
      artistName: faker.address.person.firstName(),
      artistUrl: faker.internet.httpsUrl(),
      albumCover: faker.image.image(),
      releaseYear: faker.date.year(),
    );
SongbookSearch getFakeSongbookSearch() => SongbookSearch(
      songbookId: faker.randomGenerator.integer(1000),
      songbookName: faker.address.person.firstName(),
      userName: faker.person.lastName(),
      userId: faker.randomGenerator.integer(1000).toString(),
      totalSongs: faker.randomGenerator.integer(100),
      songbookPreview: const [],
    );
