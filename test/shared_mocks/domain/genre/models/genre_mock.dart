import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/models/genre_images.dart';
import 'package:faker/faker.dart';

Genre getFakeGenre() {
  return Genre(
      name: faker.address.streetName(),
      url: faker.internet.httpsUrl(),
      genreImages: GenreImages(
        light: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-light.svg",
        lightInactive: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-inactive-light.svg",
        dark: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-dark.svg",
        darkInactive: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-inactive-dark.svg",
      ));
}
