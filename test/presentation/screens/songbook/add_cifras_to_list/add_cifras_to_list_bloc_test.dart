import 'package:async/async.dart' hide Result;
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit_state_by_count.dart';
import 'package:cifraclub/domain/search/use_case/search_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_cifras.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/add_cifra_tile/song_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/search/models/search_mock.dart';

class _GetProStatusStream extends Mock implements GetProStatusStream {}

class _SearchSongs extends Mock implements SearchSongs {}

class _GetTabsLimit extends Mock implements GetTabsLimit {}

class _GetTotalSongbookCifrasMock extends Mock implements GetTotalSongbookCifras {}

class _GetTabLimitStateByCountMock extends Mock implements GetTabLimitStateByCount {}

void main() {
  AddCifrasToListBloc getBloc({
    _GetProStatusStream? getProStatusStream,
    _SearchSongs? searchSongs,
    _GetTabsLimit? getTabsLimit,
    _GetTotalSongbookCifrasMock? getTabsLimitState,
    _GetTabLimitStateByCountMock? getTabLimitStateByCount,
  }) =>
      AddCifrasToListBloc(
        searchSongs ?? _SearchSongs(),
        getProStatusStream ?? _GetProStatusStream(),
        getTabsLimit ?? _GetTabsLimit(),
        getTabsLimitState ?? _GetTotalSongbookCifrasMock(),
        getTabLimitStateByCount ?? _GetTabLimitStateByCountMock(),
      );

  group("When init bloc", () {
    final getTabsLimitState = _GetTotalSongbookCifrasMock();
    when(() => getTabsLimitState(10)).thenAnswer((_) => BehaviorSubject.seeded(99));

    final getProStatusStream = _GetProStatusStream();
    when(getProStatusStream).thenAnswer((_) => BehaviorSubject.seeded(false));

    final getTabsLimit = _GetTabsLimit();
    when(() => getTabsLimit(false)).thenReturn(100);

    final getTabLimitStateByCount = _GetTabLimitStateByCountMock();
    when(() => getTabLimitStateByCount(any(), any())).thenReturn(ListLimitState.atWarning);

    blocTest(
      "should load correctly all started infos",
      build: () => getBloc(
        getTabsLimitState: getTabsLimitState,
        getProStatusStream: getProStatusStream,
        getTabsLimit: getTabsLimit,
        getTabLimitStateByCount: getTabLimitStateByCount,
      ),
      act: (bloc) => bloc.init(10),
      verify: (bloc) {
        expect(bloc.state.limitState, ListLimitState.atWarning);
        expect(bloc.state.isPro, false);
        expect(bloc.state.tabsLimit, 100);
      },
    );
  });

  group("When 'addOrRemoveCifra' is called", () {
    final songSearch = getFakeSongSearch();

    final getTabsLimitStateByCount = _GetTabLimitStateByCountMock();
    when(() => getTabsLimitStateByCount(false, any())).thenReturn(ListLimitState.withinLimit);

    blocTest(
      "should add and remove correctly",
      build: () => getBloc(getTabLimitStateByCount: getTabsLimitStateByCount),
      act: (bloc) {
        bloc.addOrRemoveCifra(songSearch); //Add Song
        bloc.addOrRemoveCifra(songSearch); //Remove Song
      },
      expect: () => [
        isA<AddCifrasToListState>()
            .having((state) => state.limitState, "limit state", ListLimitState.withinLimit)
            .having((state) => state.tabsCount, "add 1 to count", 1)
            .having((state) => state.selectedCifras, "add song to list", [songSearch]),
        isA<AddCifrasToListState>()
            .having((state) => state.limitState, "limit state", ListLimitState.withinLimit)
            .having((state) => state.tabsCount, "remove 1 to count", 0)
            .having((state) => state.selectedCifras, "remove song to list", []),
      ],
    );
  });

  group("When 'clearCount' is called", () {
    final getTabsLimitStateByCount = _GetTabLimitStateByCountMock();
    when(() => getTabsLimitStateByCount(false, any())).thenReturn(ListLimitState.withinLimit);

    blocTest(
      "should clear selected cifras",
      build: () => getBloc(getTabLimitStateByCount: getTabsLimitStateByCount),
      act: (bloc) {
        //Emit a state with list of select cifras and tabs count before call function
        bloc.emit(AddCifrasToListState(selectedCifras: [getFakeSongSearch(), getFakeSongSearch()], tabsCount: 2));
        bloc.clearCount();
      },
      verify: (bloc) {
        expect(bloc.state.tabsCount, 0);
        expect(bloc.state.selectedCifras, List.empty());
      },
    );
  });

  group("When 'clearList' is called", () {
    blocTest(
      "should clear songs",
      build: getBloc,
      act: (bloc) {
        //Emit a state with songs before call function
        bloc.emit(AddCifrasToListState(songs: [getFakeSongSearch(), getFakeSongSearch()]));
        bloc.clearList();
      },
      verify: (bloc) {
        expect(bloc.state.songs, List.empty());
      },
    );
  });

  group("When 'getSongState' is called", () {
    final bloc = getBloc();

    test("and song is not in localDB and not included in remote should return toAdd state", () {
      final song = getFakeSongSearch();

      final result = bloc.getSongState(song);
      expect(result, SongState.toAdd);
    });

    test("and song is in localDB and not included in remote should return selected state", () {
      final song = getFakeSongSearch();
      bloc.emit(AddCifrasToListState(selectedCifras: [song]));

      final result = bloc.getSongState(song);
      expect(result, SongState.selected);
    });

    test("and song is not in localDB and included in remote should return added state", () {
      final song = getFakeSongSearch();

      //Mudar isso para o mock do useCase que pega a lista de ids de um songbook
      bloc.mockedList.add(song.songId);

      final result = bloc.getSongState(song);
      expect(result, SongState.added);
    });
  });

  group("When 'searchSongs' is called", () {
    final songs = [getFakeSongSearch(), getFakeSongSearch()];

    final searchSong = _SearchSongs();
    when(() => searchSong(query: any(named: "query")))
        .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(songs))));

    blocTest(
      "should show loading after hide loading and emit list of songs",
      build: () => getBloc(searchSongs: searchSong),
      act: (bloc) => bloc.searchSongs("a"),
      expect: () => [
        isA<AddCifrasToListState>().having((state) => state.isLoading, "loading true", true),
      ],
    );
  });

  group("When init bloc and request search stream is called", () {
    final getTabsLimitState = _GetTotalSongbookCifrasMock();
    when(() => getTabsLimitState(10)).thenAnswer((_) => BehaviorSubject.seeded(99));

    final getProStatusStream = _GetProStatusStream();
    when(getProStatusStream).thenAnswer((_) => BehaviorSubject.seeded(false));

    final getTabsLimit = _GetTabsLimit();
    when(() => getTabsLimit(false)).thenReturn(100);

    final getTabLimitStateByCount = _GetTabLimitStateByCountMock();
    when(() => getTabLimitStateByCount(any(), any())).thenReturn(ListLimitState.atWarning);

    group("When request is sucessful", () {
      final songs = [getFakeSongSearch(), getFakeSongSearch()];

      final searchSong = _SearchSongs();
      when(() => searchSong(query: any(named: "query")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(songs))));

      blocTest(
        "should show loading and return list of songs",
        build: () => getBloc(
            getTabsLimitState: getTabsLimitState,
            getProStatusStream: getProStatusStream,
            getTabsLimit: getTabsLimit,
            searchSongs: searchSong,
            getTabLimitStateByCount: getTabLimitStateByCount),
        act: (bloc) async {
          bloc.init(10);
          bloc.searchSongs("a");
          await Future.delayed(const Duration(milliseconds: 400));
        },
        expect: () => [
          isA<AddCifrasToListState>(),
          isA<AddCifrasToListState>(),
          isA<AddCifrasToListState>().having((state) => state.isLoading, "start request", isTrue),
          isA<AddCifrasToListState>()
              .having((state) => state.songs, "songs list result", songs)
              .having((state) => state.isLoading, "finish request", isFalse),
        ],
      );
    });

    group("When request fails", () {
      final searchSong = _SearchSongs();
      when(() => searchSong(query: any(named: "query")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Err(ConnectionError()))));

      final getTabLimitStateByCount = _GetTabLimitStateByCountMock();
      when(() => getTabLimitStateByCount(any(), any())).thenReturn(ListLimitState.atWarning);

      blocTest(
        "should show loading and return emprty list",
        build: () => getBloc(
          getTabsLimitState: getTabsLimitState,
          getProStatusStream: getProStatusStream,
          getTabsLimit: getTabsLimit,
          searchSongs: searchSong,
          getTabLimitStateByCount: getTabLimitStateByCount,
        ),
        act: (bloc) async {
          bloc.init(10);
          bloc.searchSongs("a");
          await Future.delayed(const Duration(milliseconds: 400));
        },
        expect: () => [
          isA<AddCifrasToListState>(),
          isA<AddCifrasToListState>(),
          isA<AddCifrasToListState>().having((state) => state.isLoading, "start request", isTrue),
          isA<AddCifrasToListState>().having((state) => state.songs, "songs list result", []).having(
              (state) => state.isLoading, "finish request", isFalse),
        ],
      );
    });
  });
}
