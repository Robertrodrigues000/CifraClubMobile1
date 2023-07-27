import 'package:cifraclub/data/songbook/models/songbook_version_artist_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';

class _VersionArtistDtoMock extends Mock implements SongbookVersionArtistDto {}

void main() {
  test("When toDomain is called, should return correct domain entity", () {
    final versionArtistDto = _VersionArtistDtoMock();
    final artist = getFakeArtist();
    when(versionArtistDto.toDomain).thenReturn(artist);

    final songbookVersionDto = SongbookVersionDto(
      remoteDatabaseID: 42,
      name: "cifra name",
      type: 1,
      songUrl: "cifra-name",
      tone: "F",
      songId: 2,
      artist: versionArtistDto,
      versionId: 10,
    );

    final version = songbookVersionDto.toDomain(10);

    verify(versionArtistDto.toDomain).called(1);
    expect(songbookVersionDto.remoteDatabaseID, version.remoteDatabaseID);
    expect(songbookVersionDto.name, version.name);
    expect(songbookVersionDto.type, version.type);
    expect(songbookVersionDto.tone, version.tone);
    expect(songbookVersionDto.songId, version.songId);
    expect(songbookVersionDto.versionId, version.versionId);
    expect(artist, version.artist);
    expect(version.order, 10);
  });
}
