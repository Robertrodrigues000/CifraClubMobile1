import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_mock.dart';

class _GetAllVersionsFromSongbookMock extends Mock implements GetAllVersionsFromSongbook {}

void main() {
  group("When call 'getSongbook' should emit list of versions", () {
    final getAllVersionsFromSongbook = _GetAllVersionsFromSongbookMock();
    final songbook = getFakeSongbook();
    final versions = [getFakeVersion(), getFakeVersion()];

    when(() => getAllVersionsFromSongbook.call(songbook.id ?? 0)).thenAnswer((_) => SynchronousFuture(versions));

    blocTest("should emit list of versions",
        build: () => VersionsBloc(getAllVersionsFromSongbook),
        act: (bloc) => bloc.getSongbook(songbook),
        expect: () => [isA<VersionsState>().having((state) => state.versions, "versions", versions)]);
  });
}
