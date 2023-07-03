import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../matchers/are_lists_equal.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

EditListBloc _getBloc(
    {EditListState state = const EditListState(
      songbookId: 0,
    )}) {
  return EditListBloc(initialState: state);
}

void main() {
  group("When deleteVersion is called", () {
    blocTest(
      "should remove version from list",
      build: () => _getBloc(
        state: EditListState(
          songbookId: 0,
          versions: [getFakeVersion(), getFakeVersion()],
        ),
      ),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.versions.length == 1)],
    );

    blocTest(
      "add removed version in deletedVersions",
      build: () => _getBloc(
        state: EditListState(
          songbookId: 0,
          versions: [getFakeVersion(), getFakeVersion()],
        ),
      ),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.deletedVersions.length == 1)],
    );

    blocTest(
      "emit hasChanges=true",
      build: () => _getBloc(
        state: EditListState(
          songbookId: 0,
          versions: [getFakeVersion(), getFakeVersion()],
        ),
      ),
      act: (bloc) => bloc.deleteVersion(1),
      expect: () => [predicate<EditListState>((state) => state.hasChanges == true)],
    );
  });

  test("When onReorderList is called, should emit a new state with the modified list", () async {
    final versions = [getFakeVersion(versionId: 0), getFakeVersion(versionId: 1), getFakeVersion(versionId: 2)];
    final expectedList = [versions[2], versions[0], versions[1]];

    final bloc = _getBloc(state: EditListState(songbookId: 0, versions: versions));
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
