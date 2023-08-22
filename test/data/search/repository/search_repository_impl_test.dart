import 'package:async/async.dart';
import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/data/search/models/search_result_dto.dart';
import 'package:cifraclub/data/search/models/search_response_dto.dart';
import 'package:cifraclub/data/search/repository/search_repository_impl.dart';
import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/models/search_result.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/search/models/search_mock.dart';

class _SearchDataSourceMock extends Mock implements SearchDataSource {}

class _SearchListDtoMock extends Mock implements SearchResultDto {}

void main() {
  group("When getAll() is called", () {
    test("Request successful", () async {
      final searchDataSource = _SearchDataSourceMock();
      final searchListDto = _SearchListDtoMock();
      final searchResult = SearchResult(search: [getFakeArtistSearch(), getFakeSongSearch()]);

      when(() => searchDataSource.getAll(query: "lifehouse")).thenAnswer(
          (_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(SearchResponseDto(response: searchListDto)))));

      when(searchListDto.toDomain).thenAnswer((_) => searchResult);

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final result = await repository
          .getAll(
            query: "lifehouse",
          )
          .value;

      verify(searchListDto.toDomain).called(1);
      verify(() => searchDataSource.getAll(query: "lifehouse")).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), searchResult.search);
    });

    test("Has search filter and request is successful", () async {
      final searchDataSource = _SearchDataSourceMock();
      final searchListDto = _SearchListDtoMock();
      final searchResult = SearchResult(search: [getFakeSongSearch()]);

      when(() => searchDataSource.getAll(query: "lifehouse", search: "2")).thenAnswer(
          (_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(SearchResponseDto(response: searchListDto)))));

      when(searchListDto.toDomain).thenAnswer((_) => searchResult);

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final result = await repository.getAll(query: "lifehouse", searchFilter: SearchFilter.songs).value;

      verify(searchListDto.toDomain).called(1);
      verify(() => searchDataSource.getAll(query: "lifehouse", search: "2")).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), searchResult.search);
    });

    test("Request failed", () async {
      final searchDataSource = _SearchDataSourceMock();

      when(() => searchDataSource.getAll(query: "lifehouse")).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(Err(ServerError(statusCode: 404))),
        ),
      );

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final allGenres = await repository
          .getAll(
            query: "lifehouse",
          )
          .value;

      expect(allGenres.isSuccess, false);
      expect(allGenres.getError(), isA<ServerError>());
      expect((allGenres.getError() as ServerError).statusCode, 404);
    });
  });

  group("When getSongs() is called", () {
    test("Request successful", () async {
      final searchDataSource = _SearchDataSourceMock();
      final searchListDto = _SearchListDtoMock();
      final allSearch = SearchResult(search: [getFakeSongSearch(), getFakeSongSearch()]);

      when(() => searchDataSource.getSongs(query: "ava")).thenAnswer(
          (_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(SearchResponseDto(response: searchListDto)))));

      when(searchListDto.toDomain).thenAnswer((_) => allSearch);

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final result = await repository.getSongs(query: "ava").value;

      verify(searchListDto.toDomain).called(1);
      verify(() => searchDataSource.getSongs(query: "ava")).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), allSearch.search);
    });

    test("Request failed", () async {
      final searchDataSource = _SearchDataSourceMock();

      when(() => searchDataSource.getSongs(query: "ava")).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(Err(ServerError(statusCode: 404))),
        ),
      );

      final repository = SearchRepositoryImpl(searchDataSource: searchDataSource);
      final allGenres = await repository.getSongs(query: "ava").value;

      expect(allGenres.isSuccess, false);
      expect(allGenres.getError(), isA<ServerError>());
      expect((allGenres.getError() as ServerError).statusCode, 404);
    });
  });
}
