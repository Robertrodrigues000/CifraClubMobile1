import 'package:cifraclub/data/version/models/user_version/user_version_data_genre_images_dto.dart';
import 'package:cifraclub/domain/genre/models/genre_images.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final genreImages = GenreImages(
      light: "https://example.com/light.jpg",
      lightInactive: "https://example.com/light_inactive.jpg",
      dark: "https://example.com/dark.jpg",
      darkInactive: "https://example.com/dark_inactive.jpg",
    );

    final userVersionDataGenreImagesDto = UserVersionDataGenreImagesDto.fromDomain(genreImages);

    expect(userVersionDataGenreImagesDto.light, "https://example.com/light.jpg");
    expect(userVersionDataGenreImagesDto.lightInactive, "https://example.com/light_inactive.jpg");
    expect(userVersionDataGenreImagesDto.dark, "https://example.com/dark.jpg");
    expect(userVersionDataGenreImagesDto.darkInactive, "https://example.com/dark_inactive.jpg");
  });
}
