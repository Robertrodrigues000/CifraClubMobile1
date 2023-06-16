import 'package:cifraclub/data/artist/models/album_image_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when `toDomain` is called", () {
    test("should correctly convert to album image", () async {
      const albumImageDto = AlbumImageDto(
        width: 400,
        height: 400,
        image: "https://akamai.sscdn.co/letras/50x50/fotos/d/7/b/d/d7bdb8738aa4d1cdfa9d39dbc75d2b12-tb2.jpg",
        thumb: "https://akamai.sscdn.co/letras/162x162/fotos/d/7/b/d/d7bdb8738aa4d1cdfa9d39dbc75d2b12.jpg",
        imageHq: "https://akamai.sscdn.co/letras/250x250/fotos/d/7/b/d/d7bdb8738aa4d1cdfa9d39dbc75d2b12.jpg",
        color: "#BDBDBD",
      );
      final albumImage = albumImageDto.toDomain();

      expect(albumImage.image, albumImage.image);
      expect(albumImage.imageHq, albumImage.imageHq);
      expect(albumImage.thumb, albumImage.thumb);
      expect(albumImage.color, albumImage.color);
      expect(albumImage.height, albumImage.height);
      expect(albumImage.width, albumImage.width);
    });
  });
}
