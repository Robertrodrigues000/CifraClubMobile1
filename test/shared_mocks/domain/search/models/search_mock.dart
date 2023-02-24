import 'package:cifraclub/domain/search/models/artist_search.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:faker/faker.dart';

ArtistSearch getFakeArtistSearch() => ArtistSearch(
    id: faker.randomGenerator.integer(1000),
    name: faker.address.person.name(),
    url: faker.address.person.firstName(),
    imageUrl: faker.image.image());

SongSearch getFakeSongSearch() => SongSearch(
    songId: faker.randomGenerator.integer(1000),
    songName: faker.address.person.lastName(),
    songUrl: faker.internet.httpsUrl(),
    artistId: faker.randomGenerator.integer(1000),
    artistName: faker.address.person.name(),
    artistUrl: faker.address.person.firstName(),
    artistImage: faker.image.image());
