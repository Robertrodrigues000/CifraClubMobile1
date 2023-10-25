import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/is_version_on_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

void main() {
  final userVersionRepository = _UserVersionRepositoryMock();

  test("When versionId is already on songbook should return true", () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    when(() => userVersionRepository.getIsVersionOnSongbook(any(), any())).thenAnswer((_) => SynchronousFuture(true));
    final result = await IsVersionOnSongbook(
      userVersionRepository,
    )(versions.first.versionId, ListType.favorites.localId);

    verify(() => userVersionRepository.getIsVersionOnSongbook(ListType.favorites.localId, versions.first.versionId))
        .called(1);
    expect(result, isTrue);
  });

  test("When versionId is not on songbook should return false", () async {
    final version = getFakeVersion();
    when(() => userVersionRepository.getIsVersionOnSongbook(any(), any())).thenAnswer((_) => SynchronousFuture(false));

    final result = await IsVersionOnSongbook(
      userVersionRepository,
    )(version.versionId, ListType.favorites.localId);

    verify(() => userVersionRepository.getIsVersionOnSongbook(ListType.favorites.localId, version.versionId)).called(1);
    expect(result, isFalse);
  });
}
