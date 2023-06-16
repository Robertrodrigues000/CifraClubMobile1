import 'package:cifraclub/data/artist/models/album_dto.dart';
import 'package:cifraclub/data/artist/models/album_image_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/album_image_mock.dart';

class _AlbumImageDtoMock extends Mock implements AlbumImageDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to Album", () async {
    final albumImage = getFakeAlbumImage();
    final albumImageDto = _AlbumImageDtoMock();
    when(albumImageDto.toDomain).thenReturn(albumImage);

    final albumDto = AlbumDto(
      id: 57,
      artistName: "The Beatles",
      artistUrl: "the-beatles",
      albumUrl: "besouros",
      title: "Besouros em liverpool",
      image: albumImageDto,
    );
    final album = albumDto.toDomain();

    verify(albumImageDto.toDomain).called(1);

    expect(album.id, albumDto.id);
    expect(album.artistName, albumDto.artistName);
    expect(album.artistUrl, albumDto.artistUrl);
    expect(album.albumUrl, albumDto.albumUrl);
    expect(album.title, albumDto.title);
    expect(album.image, albumImage);
  });
}
