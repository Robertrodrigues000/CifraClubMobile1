import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../matchers/are_lists_equal.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

void main() {
  test("when fromSongbook is called, parse data from the given songbook", () {
    final versions = [getFakeVersion(), getFakeVersion(), getFakeVersion()];
    final state = EditListState.fromSongbook(versions, 0);

    expect(
      state.versions,
      AreListsEqual(list: versions, isElementEqual: identical),
    );
    expect(state.hasChanges, false);
    expect(state.deletedVersions, []);
    expect(state.songbookId, 0);
  });
}
