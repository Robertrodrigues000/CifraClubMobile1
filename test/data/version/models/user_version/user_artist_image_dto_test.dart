import 'package:cifraclub/data/version/models/user_version/user_artist_image_dto.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    const artistImage = ArtistImage(
      size50: "https://example.com/size50.jpg",
      size162: "https://example.com/size162.jpg",
      size250: "https://example.com/size250.jpg",
      color: "red",
    );

    final userVersionDataArtistImageDto = UserVersionDataArtistImageDto.fromDomain(artistImage);

    expect(userVersionDataArtistImageDto.size50, "https://example.com/size50.jpg");
    expect(userVersionDataArtistImageDto.size162, "https://example.com/size162.jpg");
    expect(userVersionDataArtistImageDto.size250, "https://example.com/size250.jpg");
    expect(userVersionDataArtistImageDto.color, "red");
  });
}
