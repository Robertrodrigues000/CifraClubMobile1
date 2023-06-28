import 'package:cifraclub/data/songbook/models/songbook_version_artist_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When `toDomain` is called should return Artist", () {
    const versionArtistDto = SongbookVersionArtistDto(id: 1, name: "name", url: "url", image: "image", color: "color");

    final artist = versionArtistDto.toDomain();

    expect(artist.id, 1);
    expect(artist.name, "name");
    expect(artist.url, "url");
    expect(artist.image?.color, "color");
    expect(artist.image?.size162, "image");
  });
}
