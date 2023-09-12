import 'package:async/async.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/use_cases/search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/search/models/search_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetAllVersionsFromSongbookMock extends Mock implements GetAllVersionsFromSongbook {}

class _SearchMock extends Mock implements Search {}

void main() {
  SearchBloc getBloc({
    _GetAllVersionsFromSongbookMock? getAllVersionsFromSongbook,
    _SearchMock? search,
  }) =>
      SearchBloc(
        getAllVersionsFromSongbook ?? _GetAllVersionsFromSongbookMock(),
        search ?? _SearchMock(),
      );

  group("When call 'init'", () {
    final versions = [getFakeVersion(), getFakeVersion()];

    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    when(() => getAllVersionsFromSongbook(any())).thenAnswer((_) => SynchronousFuture(versions));

    blocTest(
      "should emit a list of recent versions",
      build: () => getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook),
      act: (bloc) async {
        await bloc.init();
      },
      expect: () => [isA<SearchState>().having((state) => state.recent, "recent", versions)],
    );
  });

  group("When 'clearList' is called", () {
    blocTest(
      "should clear songs",
      build: getBloc,
      act: (bloc) {
        bloc.emit(SearchState(shouldShowRecent: false, result: [getFakeArtistSearch(), getFakeSongSearch()]));
        bloc.clearList();
      },
      verify: (bloc) {
        expect(bloc.state.shouldShowRecent, true);
        expect(bloc.state.result, List.empty());
      },
    );
  });

  group("When 'search' is called", () {
    blocTest(
      "should show loading then emit result",
      build: getBloc,
      act: (bloc) => bloc.search("a"),
      expect: () => [isA<SearchState>().having((state) => state.isLoading, "loading true", true)],
    );
  });

  group("When init bloc and request search stream is called", () {
    final versions = [getFakeVersion(), getFakeVersion()];

    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    when(() => getAllVersionsFromSongbook(any())).thenAnswer((_) => SynchronousFuture(versions));

    group("When request is successful", () {
      final result = [getFakeSongSearch(), getFakeSongSearch(), getFakeArtistSearch()];

      final search = _SearchMock();
      when(() => search(query: any(named: "query")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(result))));

      blocTest(
        "should show loading and return list of songs",
        build: () => getBloc(
          getAllVersionsFromSongbook: getAllVersionsFromSongbook,
          search: search,
        ),
        act: (bloc) async {
          bloc.init();
          bloc.search("a");
          await Future.delayed(const Duration(milliseconds: 400));
        },
        expect: () => [
          isA<SearchState>(),
          isA<SearchState>().having((state) => state.isLoading, "start request", isTrue),
          isA<SearchState>()
              .having((state) => state.result, "result", result)
              .having((state) => state.isLoading, "finish request", isFalse),
        ],
      );
    });

    group("When request fails", () {
      final versions = [getFakeVersion(), getFakeVersion()];

      final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
      when(() => getAllVersionsFromSongbook(any())).thenAnswer((_) => SynchronousFuture(versions));

      final search = _SearchMock();
      when(() => search(query: any(named: "query")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Err(ConnectionError()))));

      blocTest(
        "should show loading and return empty list",
        build: () => getBloc(
          getAllVersionsFromSongbook: getAllVersionsFromSongbook,
          search: search,
        ),
        act: (bloc) async {
          bloc.init();
          bloc.search("a");
          await Future.delayed(const Duration(milliseconds: 400));
        },
        expect: () => [
          isA<SearchState>(),
          isA<SearchState>().having((state) => state.isLoading, "start request", isTrue),
          isA<SearchState>()
              .having((state) => state.error, "error", isNotNull)
              .having((state) => state.isLoading, "finish request", isFalse),
        ],
      );
    });
  });

  group("When onFilterSelected is called", () {
    const selectedFilter = SearchFilter.artists;
    final result = [getFakeArtistSearch(), getFakeArtistSearch()];

    final search = _SearchMock();
    when(() => search(query: "a", searchFilter: selectedFilter))
        .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(result))));

    blocTest("should update the current state with selected filter and search again",
        build: () => getBloc(search: search),
        act: (bloc) => bloc.onFilterSelected(selectedFilter, "a"),
        verify: (bloc) {
          expect(bloc.state.selectedFilter, SearchFilter.artists);
        });
  });

  group("When 'search' is called", () {
    final result = [getFakeSongSearch(), getFakeArtistSearch()];

    final search = _SearchMock();
    when(() => search(query: any(named: "query")))
        .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(result))));

    blocTest(
      "should show loading then emit list of results",
      build: () => getBloc(search: search),
      act: (bloc) => bloc.search("a"),
      expect: () => [
        isA<SearchState>().having((state) => state.isLoading, "loading true", true),
      ],
    );
  });

  group("When 'clearList' is called", () {
    blocTest(
      "should clear songs",
      build: getBloc,
      act: (bloc) {
        bloc.emit(SearchState(result: [getFakeSongSearch(), getFakeArtistSearch()]));
        bloc.clearList();
      },
      verify: (bloc) {
        expect(bloc.state.result, List.empty());
      },
    );
  });
}
