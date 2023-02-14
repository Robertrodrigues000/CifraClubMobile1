import 'package:cifraclub/data/search/models/search_list_dto.dart';
import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/search/models/all_search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/search/models/search_mock.dart';

class _MockSearchDto extends Mock implements SearchDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to AllSearch", () {
    final searchDtoArtist = _MockSearchDto();
    final fakeSearchArtist = getFakeArtistSearch();
    when(searchDtoArtist.toDomain).thenReturn(fakeSearchArtist);

    final searchDtoSong = _MockSearchDto();
    final fakeSearchSong = getFakeSongSearch();
    when(searchDtoSong.toDomain).thenReturn(fakeSearchSong);

    final allSearchDto = SearchListDto(docs: [searchDtoArtist, searchDtoSong]);

    AllSearch allSearch = allSearchDto.toDomain();

    verify(searchDtoArtist.toDomain).called(1);
    verify(searchDtoSong.toDomain).called(1);

    expect(allSearch.search.length, 2);
    expect(allSearch.search.first, fakeSearchArtist);
    expect(allSearch.search.last, fakeSearchSong);
  });
}
