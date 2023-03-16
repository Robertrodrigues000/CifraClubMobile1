import 'package:cifraclub/data/genre/models/genre_images_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called, should correctly convert to Genre", () {
    final genreImagesDto = GenreImagesDto(
      light: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-light.svg",
      lightInactive: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-inactive-light.svg",
      dark: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-dark.svg",
      darkInactive: "https://akamai.sscdn.co/gcs/cifraclub/genres/rock-inactive-dark.svg",
    );
    final genreImages = genreImagesDto.toDomain();

    expect(genreImagesDto.light, genreImages.light);
    expect(genreImagesDto.lightInactive, genreImages.lightInactive);
    expect(genreImagesDto.dark, genreImages.dark);
    expect(genreImagesDto.darkInactive, genreImages.darkInactive);
  });
}
