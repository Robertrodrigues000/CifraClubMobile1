import 'package:cifraclub/data/artist/models/album_detail_dto.dart';
import 'package:cifraclub/data/artist/models/album_disc_dto.dart';
import 'package:cifraclub/data/artist/models/album_image_dto.dart';
import 'package:cifraclub/domain/artist/models/album_disc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/album_disc_song_mock.dart';
import '../../../shared_mocks/domain/artist/models/album_image_mock.dart';

class _AlbumDiscDtoMock extends Mock implements AlbumDiscDto {}

class _AlbumImageDtoMock extends Mock implements AlbumImageDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to AlbumDetail", () async {
    final albumImage = getFakeAlbumImage();
    final albumDiscSong = getFakeAlbumDiscSong();
    final albumImageDto = _AlbumImageDtoMock();
    final albumDiscDto = _AlbumDiscDtoMock();

    when(albumImageDto.toDomain).thenReturn(albumImage);
    when(albumDiscDto.toDomain).thenReturn(AlbumDisc(songs: [albumDiscSong]));

    final albumDetailDto = AlbumDetailDto(
      id: 57,
      discs: [albumDiscDto],
      artistName: "The Beatles",
      artistUrl: "the-beatles",
      albumUrl: "besouros",
      title: "Besouros em liverpool",
      image: albumImageDto,
    );
    final albumDetail = albumDetailDto.toDomain();

    verify(albumImageDto.toDomain).called(1);

    expect(albumDetail.id, albumDetailDto.id);
    expect(albumDetail.discs.first.songs.first, albumDiscSong);
    expect(albumDetail.artistName, albumDetailDto.artistName);
    expect(albumDetail.artistUrl, albumDetailDto.artistUrl);
    expect(albumDetail.albumUrl, albumDetailDto.albumUrl);
    expect(albumDetail.title, albumDetailDto.title);
    expect(albumDetail.image, albumImage);
  });
}
