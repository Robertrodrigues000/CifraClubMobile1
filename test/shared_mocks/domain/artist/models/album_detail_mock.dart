import 'package:cifraclub/domain/artist/models/album_detail.dart';
import 'package:faker/faker.dart';

AlbumDetail getFakeAlbumDetail() => AlbumDetail(
      artistName: faker.animal.name(),
      discs: const [],
      id: faker.randomGenerator.integer(100),
      artistUrl: faker.internet.domainName(),
      albumUrl: faker.internet.domainName(),
      title: faker.animal.name(),
    );
