import 'package:cifraclub/data/version/models/user_version/user_version_data_artist_dto.dart';
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/artist/models/artist_image_mock.dart';
import '../../../../shared_mocks/domain/genre/models/genre_mock.dart';

void main() {
  test("When call 'fromDomain'", () {
    final artist = Artist(
      id: 1,
      name: "Queen",
      url: "https://www.queenonline.com/",
      image: getFakeArtistImage(),
      genre: getFakeGenre(),
    );

    final userVersionDataArtistDto = UserVersionDataArtistDto.fromDomain(artist);

    expect(userVersionDataArtistDto.id, 1);
    expect(userVersionDataArtistDto.name, "Queen");
    expect(userVersionDataArtistDto.url, "https://www.queenonline.com/");
  });
}
