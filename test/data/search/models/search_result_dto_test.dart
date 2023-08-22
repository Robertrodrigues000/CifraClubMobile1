import 'package:cifraclub/data/search/models/search_result_dto.dart';
import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/search/models/search_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/search/models/search_mock.dart';

class _SearchDtoMock extends Mock implements SearchDto {}

void main() {
  test("when `toDomain` is called, should correctly convert to SearchResult", () {
    final searchDtoArtist = _SearchDtoMock();
    final fakeSearchArtist = getFakeArtistSearch();
    when(searchDtoArtist.toDomain).thenReturn(fakeSearchArtist);

    final searchDtoSong = _SearchDtoMock();
    final fakeSearchSong = getFakeSongSearch();
    when(searchDtoSong.toDomain).thenReturn(fakeSearchSong);

    final searchResultDto = SearchResultDto(docs: [searchDtoArtist, searchDtoSong]);

    SearchResult searchResult = searchResultDto.toDomain();

    verify(searchDtoArtist.toDomain).called(1);
    verify(searchDtoSong.toDomain).called(1);

    expect(searchResult.search.length, 2);
    expect(searchResult.search.first, fakeSearchArtist);
    expect(searchResult.search.last, fakeSearchSong);
  });

  test("when `toDomain` is called and SearchResultDto returns a null list, should convert to an empty list", () {
    const searchResultDto = SearchResultDto(docs: null);
    SearchResult searchResult = searchResultDto.toDomain();

    expect(searchResult.search.length, 0);
    expect(searchResult.search, List.empty());
  });

  test(
      "when `toDomain` is called and SearchResultDto returns a list with null objects, should return non-null objects list",
      () {
    final searchDtoArtist = _SearchDtoMock();
    final fakeSearchArtist = getFakeArtistSearch();
    when(searchDtoArtist.toDomain).thenReturn(fakeSearchArtist);

    final searchDtoSong = _SearchDtoMock();
    when(searchDtoSong.toDomain).thenReturn(null);

    final searchResultDto = SearchResultDto(docs: [searchDtoArtist, searchDtoSong]);

    SearchResult searchResult = searchResultDto.toDomain();

    verify(searchDtoArtist.toDomain).called(1);
    verify(searchDtoSong.toDomain).called(1);

    expect(searchResult.search.length, 1);
    expect(searchResult.search.first, fakeSearchArtist);
  });
}
