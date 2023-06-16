import 'package:cifraclub/domain/artist/models/album_image.dart';
import 'package:faker/faker.dart';

AlbumImage getFakeAlbumImage() {
  return AlbumImage(
    color: faker.animal.name(),
    height: faker.randomGenerator.integer(100),
    width: faker.randomGenerator.integer(100),
    imageHq: faker.animal.name(),
    thumb: faker.animal.name(),
    image: faker.animal.name(),
  );
}
