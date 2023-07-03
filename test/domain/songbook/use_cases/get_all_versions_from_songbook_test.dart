import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

void main() {
  late _UserVersionRepositoryMock userVersionRepositoryMock;

  setUp(() => userVersionRepositoryMock = _UserVersionRepositoryMock());

  test("When use case is called", () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    when(() => userVersionRepositoryMock.getUserVersionsFromSongbook(100))
        .thenAnswer((_) => SynchronousFuture(versions));

    final result = await GetAllVersionsFromSongbook(userVersionRepositoryMock)(100);

    expect(result, versions);
  });
}
