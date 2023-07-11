import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../matchers/are_lists_equal.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetAllVersionsFromSongbookMock extends Mock implements GetAllVersionsFromSongbook {}

void main() {
  EditListBloc getBloc({
    _GetAllVersionsFromSongbookMock? getAllVersionsFromSongbook,
  }) =>
      EditListBloc(
        0,
        getAllVersionsFromSongbook ?? _GetAllVersionsFromSongbookMock(),
      );

  group("When call `init`", () {
    final versions = [getFakeVersion(), getFakeVersion()];
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    when(() => getAllVersionsFromSongbook(0)).thenAnswer((_) => SynchronousFuture(versions));
    blocTest(
      "should emit list of versions",
      build: () => getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook),
      act: (bloc) => bloc.init(),
      expect: () => [isA<EditListState>().having((state) => state.versions, "Versions list", versions)],
    );
  });

  group("When deleteVersion is called", () {
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    when(() => getAllVersionsFromSongbook(0))
        .thenAnswer((_) => SynchronousFuture([getFakeVersion(), getFakeVersion()]));

    blocTest(
      "should remove version from list",
      build: () => getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook)..init(),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.versions.length == 1)],
    );

    blocTest(
      "add removed version in deletedVersions",
      build: () => getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook)..init(),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.deletedVersions.length == 1)],
    );

    blocTest(
      "emit hasChanges=true",
      build: () => getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook)..init(),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.hasChanges == true)],
    );
  });

  test("When onReorderList is called, should emit a new state with the modified list", () async {
    final versions = [getFakeVersion(versionId: 0), getFakeVersion(versionId: 1), getFakeVersion(versionId: 2)];
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    when(() => getAllVersionsFromSongbook(0)).thenAnswer((_) => SynchronousFuture(versions));
    final expectedList = [versions[2], versions[0], versions[1]];

    final bloc = getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook)..init();
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
}
