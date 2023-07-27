import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/sort_versions_from_songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_event.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../matchers/are_lists_equal.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetAllVersionsFromSongbookMock extends Mock implements GetAllVersionsFromSongbook {}

class _DeleteVersionsMock extends Mock implements DeleteVersions {}

class _SortVersionFromSongbookMock extends Mock implements SortVersionsFromSongbook {}

class _GetOrderedVersionsMock extends Mock implements GetOrderedVersions {}

void main() {
  EditListBloc getBloc({
    _GetAllVersionsFromSongbookMock? getAllVersionsFromSongbook,
    _DeleteVersionsMock? deleteVersions,
    _SortVersionFromSongbookMock? sortVersionFromSongbook,
    _GetOrderedVersionsMock? getOrderedVersions,
  }) =>
      EditListBloc(
          0,
          getAllVersionsFromSongbook ?? _GetAllVersionsFromSongbookMock(),
          sortVersionFromSongbook ?? _SortVersionFromSongbookMock(),
          deleteVersions ?? _DeleteVersionsMock(),
          getOrderedVersions ?? _GetOrderedVersionsMock());

  group("When call `init`", () {
    final versions = [getFakeVersion(), getFakeVersion()];
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(ListOrderType.custom, versions, ListType.user)).thenReturn(versions);
    when(() => getAllVersionsFromSongbook(0)).thenAnswer((_) => SynchronousFuture(versions));
    blocTest(
      "should emit list of versions",
      build: () =>
          getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook, getOrderedVersions: getOrderedVersions),
      act: (bloc) => bloc.init(),
      expect: () => [isA<EditListState>().having((state) => state.versions, "Versions list", versions)],
    );
  });

  group("When deleteVersion is called", () {
    final versions = [getFakeVersion(), getFakeVersion()];
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(ListOrderType.custom, any(), ListType.user)).thenReturn(versions);
    when(() => getAllVersionsFromSongbook(0))
        .thenAnswer((_) => SynchronousFuture([getFakeVersion(), getFakeVersion()]));

    blocTest(
      "should remove version from list",
      build: () =>
          getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook, getOrderedVersions: getOrderedVersions)
            ..init(),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.versions.length == 1)],
    );

    blocTest(
      "add removed version in deletedVersions",
      build: () =>
          getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook, getOrderedVersions: getOrderedVersions)
            ..init(),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.deletedVersions.length == 1)],
    );

    blocTest(
      "emit hasChanges=true",
      build: () =>
          getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook, getOrderedVersions: getOrderedVersions)
            ..init(),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.hasChanges == true)],
    );
  });

  test("When onReorderList is called, should emit a new state with the modified list", () async {
    final versions = [getFakeVersion(versionId: 0), getFakeVersion(versionId: 1), getFakeVersion(versionId: 2)];
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    final getOrderedVersions = _GetOrderedVersionsMock();
    when(() => getOrderedVersions(ListOrderType.custom, any(), ListType.user)).thenReturn(versions);
    when(() => getAllVersionsFromSongbook(0)).thenAnswer((_) => SynchronousFuture(versions));
    final expectedList = [versions[2], versions[0], versions[1]];

    final bloc = getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook, getOrderedVersions: getOrderedVersions)
      ..init();
    bloc.onReorderList(2, 0);

    expect(
      bloc.state.versions,
      AreListsEqual<Version>(
        list: expectedList,
        isElementEqual: (a, b) => a.versionId == b.versionId,
        describeElement: (a) => a.versionId,
      ),
    );
  });

  group("When call 'save'", () {
    final deleteVersions = _DeleteVersionsMock();
    when(() => deleteVersions(songbookId: any(named: 'songbookId'), versions: any(named: 'versions')))
        .thenAnswer((_) => SynchronousFuture(const Ok(null)));

    final sortVersions = _SortVersionFromSongbookMock();
    when(() => sortVersions(any(), any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    blocTest(
      "should save order and deleted songs",
      build: () => getBloc(deleteVersions: deleteVersions, sortVersionFromSongbook: sortVersions),
      act: (bloc) async {
        bloc.emit(EditListState(
            songbookId: 0,
            deletedVersions: [getFakeVersion()],
            versions: [getFakeVersion(), getFakeVersion()],
            hasChanges: true));
        await bloc.save();
      },
      expect: () => [
        isA<EditListState>(),
        isA<EditListState>().having((state) => state.isLoading, "loading", isTrue),
        isA<EditListState>()
            .having((state) => state.isLoading, "loading", isFalse)
            .having((state) => state.hasChanges, "has changes", isFalse)
      ],
      verify: (bloc) {
        verify(() => deleteVersions(songbookId: any(named: 'songbookId'), versions: any(named: 'versions'))).called(1);
        verify(() => sortVersions(any(), any())).called(1);
      },
    );

    blocTest(
      "and don't have delete versions should save order",
      build: () => getBloc(deleteVersions: deleteVersions, sortVersionFromSongbook: sortVersions),
      act: (bloc) async {
        bloc.emit(EditListState(
          songbookId: 0,
          versions: [getFakeVersion(), getFakeVersion()],
          hasChanges: true,
        ));
        await bloc.save();
      },
      expect: () => [
        isA<EditListState>(),
        isA<EditListState>().having((state) => state.isLoading, "loading", isTrue),
        isA<EditListState>()
            .having((state) => state.isLoading, "loading", isFalse)
            .having((state) => state.hasChanges, "has changes", isFalse)
      ],
      verify: (bloc) {
        verifyNever(() => deleteVersions(songbookId: any(named: 'songbookId'), versions: any(named: 'versions')));
        verify(() => sortVersions(any(), any())).called(1);
      },
    );
  });

  group("When call 'save' and an error occurs in the request", () {
    final deleteVersions = _DeleteVersionsMock();
    when(() => deleteVersions(songbookId: any(named: 'songbookId'), versions: any(named: 'versions')))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final sortVersions = _SortVersionFromSongbookMock();
    when(() => sortVersions(any(), any())).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    blocTest(
      "should add stream event",
      build: () => getBloc(deleteVersions: deleteVersions, sortVersionFromSongbook: sortVersions),
      act: (bloc) async {
        bloc.emit(EditListState(
          songbookId: 0,
          deletedVersions: [getFakeVersion()],
          versions: [getFakeVersion(), getFakeVersion()],
          hasChanges: true,
        ));
        await bloc.save();
        expect(await bloc.editListEventStream.first, isA<ReorderError>());
      },
      expect: () => [
        isA<EditListState>(),
        isA<EditListState>().having((state) => state.isLoading, "loading", isTrue),
        isA<EditListState>()
            .having((state) => state.isLoading, "loading", isFalse)
            .having((state) => state.hasChanges, "has changes", isFalse)
      ],
      verify: (bloc) async {
        verify(() => deleteVersions(songbookId: any(named: 'songbookId'), versions: any(named: 'versions'))).called(1);
        verify(() => sortVersions(any(), any())).called(1);
      },
    );
  });
}
