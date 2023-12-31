import 'package:cifraclub/domain/artist/models/album_disc_song.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:faker/faker.dart';

AlbumDiscSong getFakeAlbumDiscSong({ArtistSong? artistSong}) => AlbumDiscSong(
      disc: faker.randomGenerator.integer(100),
      id: faker.randomGenerator.integer(100),
      name: faker.animal.name(),
      order: faker.randomGenerator.integer(100),
      artistSong: artistSong,
    );
