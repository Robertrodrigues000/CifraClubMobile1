import 'package:async/async.dart' hide Result;
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart';
import 'package:cifraclub/domain/search/use_cases/search_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/search/models/search_mock.dart';

class _GetProStatusStreamMock extends Mock implements GetProStatusStream {}

class _SearchSongsMock extends Mock implements SearchSongs {}

class _GetVersionsLimitMock extends Mock implements GetVersionsLimit {}

class _GetTotalSongbookVersionsMock extends Mock implements GetTotalSongbookVersions {}

class _GetVersionLimitStateByCountMock extends Mock implements GetVersionLimitStateByCount {}

void main() {
  AddVersionsToListBloc getBloc({
    _GetProStatusStreamMock? getProStatusStream,
    _SearchSongsMock? searchSongs,
    _GetVersionsLimitMock? getVersionsLimit,
    _GetTotalSongbookVersionsMock? getVersionsLimitState,
    _GetVersionLimitStateByCountMock? getVersionLimitStateByCount,
  }) =>
      AddVersionsToListBloc(
        searchSongs ?? _SearchSongsMock(),
        getProStatusStream ?? _GetProStatusStreamMock(),
        getVersionsLimit ?? _GetVersionsLimitMock(),
        getVersionsLimitState ?? _GetTotalSongbookVersionsMock(),
        getVersionLimitStateByCount ?? _GetVersionLimitStateByCountMock(),
      );

  group("When init bloc", () {
    final getVersionsLimitState = _GetTotalSongbookVersionsMock();
    when(() => getVersionsLimitState(10)).thenAnswer((_) => BehaviorSubject.seeded(99));

    final getProStatusStream = _GetProStatusStreamMock();
    when(getProStatusStream).thenAnswer((_) => BehaviorSubject.seeded(false));

    final getVersionsLimit = _GetVersionsLimitMock();
    when(() => getVersionsLimit(false)).thenReturn(100);

    final getVersionLimitStateByCount = _GetVersionLimitStateByCountMock();
    when(() => getVersionLimitStateByCount(any(), any())).thenReturn(ListLimitState.atWarning);

    blocTest(
      "should load correctly all started info",
      build: () => getBloc(
        getVersionsLimitState: getVersionsLimitState,
        getProStatusStream: getProStatusStream,
        getVersionsLimit: getVersionsLimit,
        getVersionLimitStateByCount: getVersionLimitStateByCount,
      ),
      act: (bloc) => bloc.init(10),
      verify: (bloc) {
        expect(bloc.state.limitState, ListLimitState.atWarning);
        expect(bloc.state.isPro, false);
        expect(bloc.state.versionsLimit, 100);
      },
    );
  });

  group("When 'addOrRemoveVersion' is called", () {
    final songSearch = getFakeSongSearch();

    final getVersionsLimitStateByCount = _GetVersionLimitStateByCountMock();
    when(() => getVersionsLimitStateByCount(false, any())).thenReturn(ListLimitState.withinLimit);

    blocTest(
      "should add and remove correctly",
      build: () => getBloc(getVersionLimitStateByCount: getVersionsLimitStateByCount),
      act: (bloc) {
        bloc.addOrRemoveVersion(songSearch); //Add Song
        bloc.addOrRemoveVersion(songSearch); //Remove Song
      },
      expect: () => [
        isA<AddVersionsToListState>()
            .having((state) => state.limitState, "limit state", ListLimitState.withinLimit)
            .having((state) => state.versionsCount, "add 1 to count", 1)
            .having((state) => state.selectedVersions, "add song to list", [songSearch]),
        isA<AddVersionsToListState>()
            .having((state) => state.limitState, "limit state", ListLimitState.withinLimit)
            .having((state) => state.versionsCount, "remove 1 to count", 0)
            .having((state) => state.selectedVersions, "remove song to list", []),
      ],
    );
  });

  group("When 'clearCount' is called", () {
    final getVersionsLimitStateByCount = _GetVersionLimitStateByCountMock();
    when(() => getVersionsLimitStateByCount(false, any())).thenReturn(ListLimitState.withinLimit);

    blocTest(
      "should clear selected versions",
      build: () => getBloc(getVersionLimitStateByCount: getVersionsLimitStateByCount),
      act: (bloc) {
        //Emit a state with list of select versions and tabs count before call function
        bloc.emit(
            AddVersionsToListState(selectedVersions: [getFakeSongSearch(), getFakeSongSearch()], versionsCount: 2));
        bloc.clearCount();
      },
      verify: (bloc) {
        expect(bloc.state.versionsCount, 0);
        expect(bloc.state.selectedVersions, List.empty());
      },
    );
  });

  group("When 'clearList' is called", () {
    blocTest(
      "should clear songs",
      build: getBloc,
      act: (bloc) {
        //Emit a state with songs before call function
        bloc.emit(AddVersionsToListState(songs: [getFakeSongSearch(), getFakeSongSearch()]));
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
      bloc.emit(AddVersionsToListState(selectedVersions: [song]));

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

    final searchSong = _SearchSongsMock();
    when(() => searchSong(query: any(named: "query")))
        .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(songs))));

    blocTest(
      "should show loading then emit list of songs",
      build: () => getBloc(searchSongs: searchSong),
      act: (bloc) => bloc.searchSongs("a"),
      expect: () => [
        isA<AddVersionsToListState>().having((state) => state.isLoading, "loading true", true),
      ],
    );
  });

  group("When init bloc and request search stream is called", () {
    final getVersionsLimitState = _GetTotalSongbookVersionsMock();
    when(() => getVersionsLimitState(10)).thenAnswer((_) => BehaviorSubject.seeded(99));

    final getProStatusStream = _GetProStatusStreamMock();
    when(getProStatusStream).thenAnswer((_) => BehaviorSubject.seeded(false));

    final getVersionsLimit = _GetVersionsLimitMock();
    when(() => getVersionsLimit(false)).thenReturn(100);

    final getVersionLimitStateByCount = _GetVersionLimitStateByCountMock();
    when(() => getVersionLimitStateByCount(any(), any())).thenReturn(ListLimitState.atWarning);

    group("When request is successful", () {
      final songs = [getFakeSongSearch(), getFakeSongSearch()];

      final searchSong = _SearchSongsMock();
      when(() => searchSong(query: any(named: "query")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(songs))));

      blocTest(
        "should show loading and return list of songs",
        build: () => getBloc(
            getVersionsLimitState: getVersionsLimitState,
            getProStatusStream: getProStatusStream,
            getVersionsLimit: getVersionsLimit,
            searchSongs: searchSong,
            getVersionLimitStateByCount: getVersionLimitStateByCount),
        act: (bloc) async {
          bloc.init(10);
          bloc.searchSongs("a");
          await Future.delayed(const Duration(milliseconds: 400));
        },
        expect: () => [
          isA<AddVersionsToListState>(),
          isA<AddVersionsToListState>(),
          isA<AddVersionsToListState>().having((state) => state.isLoading, "start request", isTrue),
          isA<AddVersionsToListState>()
              .having((state) => state.songs, "songs list result", songs)
              .having((state) => state.isLoading, "finish request", isFalse),
        ],
      );
    });

    group("When request fails", () {
      final searchSong = _SearchSongsMock();
      when(() => searchSong(query: any(named: "query")))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Err(ConnectionError()))));

      final getTabLimitStateByCount = _GetVersionLimitStateByCountMock();
      when(() => getTabLimitStateByCount(any(), any())).thenReturn(ListLimitState.atWarning);

      blocTest(
        "should show loading and return empty list",
        build: () => getBloc(
          getVersionsLimitState: getVersionsLimitState,
          getProStatusStream: getProStatusStream,
          getVersionsLimit: getVersionsLimit,
          searchSongs: searchSong,
          getVersionLimitStateByCount: getTabLimitStateByCount,
        ),
        act: (bloc) async {
          bloc.init(10);
          bloc.searchSongs("a");
          await Future.delayed(const Duration(milliseconds: 400));
        },
        expect: () => [
          isA<AddVersionsToListState>(),
          isA<AddVersionsToListState>(),
          isA<AddVersionsToListState>().having((state) => state.isLoading, "start request", isTrue),
          isA<AddVersionsToListState>().having((state) => state.songs, "songs list result", []).having(
              (state) => state.isLoading, "finish request", isFalse),
        ],
      );
    });
  });
}
