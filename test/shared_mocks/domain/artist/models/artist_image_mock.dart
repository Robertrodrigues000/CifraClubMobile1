import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:faker/faker.dart';

ArtistImage getFakeArtistImage() {
  return ArtistImage(
    size50: faker.image.image(random: true),
    size162: faker.image.image(random: true),
    size250: faker.image.image(random: true),
    color: "ffaabbcc",
  );
}
