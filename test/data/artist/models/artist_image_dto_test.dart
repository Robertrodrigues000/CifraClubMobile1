import 'package:cifraclub/data/artist/models/artist_image_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when `toDomain` is called", () {
    test("should correctly convert non-null values", () async {
      const artistImageDto = ArtistImageDto(
        size50: "https://akamai.sscdn.co/letras/50x50/fotos/d/7/b/d/d7bdb8738aa4d1cdfa9d39dbc75d2b12-tb2.jpg",
        size162: "https://akamai.sscdn.co/letras/162x162/fotos/d/7/b/d/d7bdb8738aa4d1cdfa9d39dbc75d2b12.jpg",
        size250: "https://akamai.sscdn.co/letras/250x250/fotos/d/7/b/d/d7bdb8738aa4d1cdfa9d39dbc75d2b12.jpg",
        color: "#BDBDBD",
      );
      final artistImage = artistImageDto.toDomain();

      expect(artistImage.size50, artistImage.size50);
      expect(artistImage.size162, artistImage.size162);
      expect(artistImage.size250, artistImage.size250);
      expect(artistImage.color, artistImage.color);
    });

    test("should correctly convert null values", () async {
      const artistImageDto = ArtistImageDto();
      final artistImage = artistImageDto.toDomain();

      expect(artistImage.size50, isNull);
      expect(artistImage.size162, isNull);
      expect(artistImage.size250, isNull);
      expect(artistImage.color, isNull);
    });
  });
}
