import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/data/search/models/search_list_dto.dart';
import 'package:cifraclub/data/search/models/search_response_dto.dart';
import 'package:cifraclub/data/search/repository/search_repository_impl.dart';
import 'package:cifraclub/domain/search/models/all_search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/search/models/search_mock.dart';

class _SearchDataSourceMock extends Mock implements SearchDataSource {}

class _MockAllSearchDto extends Mock implements SearchListDto {}

void main() {
  group("When getAll() is Called", () {
    test("Request successful", () async {
      final searchDataSource = _SearchDataSourceMock();
      final allSearchDto = _MockAllSearchDto();
      final allSearch = AllSearch(search: [getFakeArtistSearch(), getFakeSongSearch()]);

      when(() => searchDataSource.getAll(query: "lifehouse"))
          .thenAnswer((_) => SynchronousFuture(Ok(SearchResponseDto(response: allSearchDto))));

      when(allSearchDto.toDomain).thenAnswer((_) => allSearch);

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final result = await repository.getAll(query: "lifehouse");

      verify(allSearchDto.toDomain).called(1);
      verify(() => searchDataSource.getAll(query: "lifehouse")).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), allSearch.search);
    });

    test("Request failed", () async {
      final searchDataSource = _SearchDataSourceMock();

      when(() => searchDataSource.getAll(query: "lifehouse")).thenAnswer(
        (_) => SynchronousFuture(
          Err(ServerError()),
        ),
      );

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final allGenres = await repository.getAll(query: "lifehouse");

      expect(allGenres.isSuccess, false);
      expect(allGenres.getError(), isA<ServerError>());
      expect((allGenres.getError() as ServerError).statusCode, null);
    });
  });
}
