import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetAllVersionsFromSongbookMock extends Mock implements GetAllVersionsFromSongbook {}

void main() {
  SearchBloc getBloc({
    _GetAllVersionsFromSongbookMock? getAllVersionsFromSongbook,
  }) =>
      SearchBloc(
        getAllVersionsFromSongbook ?? _GetAllVersionsFromSongbookMock(),
      );

  group("When call 'init'", () {
    final versions = [getFakeVersion(), getFakeVersion()];

    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    when(() => getAllVersionsFromSongbook(any())).thenAnswer((_) => SynchronousFuture(versions));

    blocTest(
      "should emit a list of recents versions",
      build: () => getBloc(getAllVersionsFromSongbook: getAllVersionsFromSongbook),
      act: (bloc) async {
        await bloc.init();
      },
      expect: () => [isA<SearchState>().having((state) => state.versions, "versions", versions)],
    );
  });
}
