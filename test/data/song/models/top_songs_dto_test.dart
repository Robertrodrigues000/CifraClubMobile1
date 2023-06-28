import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:cifraclub/data/song/models/top_songs_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _SongDtoMock extends Mock implements SongDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to PaginatedList<Song>", () async {
    final songDto = _SongDtoMock();
    final song = getFakeSong();

    when(songDto.toDomain).thenReturn(song);

    final topSongsDto = TopSongsDto(
      songs: [songDto],
      moreResults: true,
    );
    final paginatedList = topSongsDto.toDomain();

    verify(songDto.toDomain).called(1);

    expect(paginatedList.items.length, topSongsDto.songs.length);
    expect(paginatedList.hasMoreResults, topSongsDto.moreResults);
    expect(paginatedList.items.first, song);
  });
}
