import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

void main() {
  test("When updateSongbookPreview is called should return id of songbook updated", () async {
    final userVersionRepository = _UserVersionRepositoryMock();
    final userSongbookRepository = _UserSongbookRepository();
    final fakeVersion = getFakeVersion();
    when(() => userVersionRepository.getImagesPreview(10))
        .thenAnswer((_) => SynchronousFuture([fakeVersion.artist.image?.size162]));
    when(() => userSongbookRepository.updateSongbookPreview(any(), any())).thenAnswer((_) => SynchronousFuture(10));

    await UpdateSongbookPreview(userVersionRepository, userSongbookRepository)(10);

    verify(() => userVersionRepository.getImagesPreview(10)).called(1);
    verify(() => userSongbookRepository.updateSongbookPreview(10, [fakeVersion.artist.image?.size162])).called(1);
  });
}
