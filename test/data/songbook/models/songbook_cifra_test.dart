import 'package:cifraclub/data/songbook/models/songbook_cifra_artist_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_cifra_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';

class _CifraArtistDtoMock extends Mock implements SongbookCifraArtistDto {}

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    final cifraArtistDto = _CifraArtistDtoMock();
    final artist = getFakeArtist();
    when(cifraArtistDto.toDomain).thenReturn(artist);

    final songbookCifraDto = SongbookCifraDto(
      remoteDatabaseID: 42,
      name: "cifra name",
      type: 1,
      songUrl: "cifra-name",
      tone: "F",
      songId: 2,
      artist: cifraArtistDto,
      versionId: 10,
    );

    final cifra = songbookCifraDto.toDomain();

    verify(cifraArtistDto.toDomain).called(1);
    expect(songbookCifraDto.remoteDatabaseID, cifra.remoteDatabaseID);
    expect(songbookCifraDto.name, cifra.name);
    expect(songbookCifraDto.type, cifra.type);
    expect(songbookCifraDto.tone, cifra.tone);
    expect(songbookCifraDto.songId, cifra.songId);
    expect(songbookCifraDto.versionId, cifra.versionId);
    expect(artist, cifra.artist);
  });
}
