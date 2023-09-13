import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionRepository extends Mock implements UserVersionRepository {}

class _SongbookRepository extends Mock implements SongbookRepository {}

class _UpdateSongbookPreview extends Mock implements UpdateSongbookPreview {}

void main() {
  late _UserVersionRepository userVersionRepository;
  late _SongbookRepository songbookRepository;
  late _UpdateSongbookPreview updateSongbookPreview;

  setUp(() {
    userVersionRepository = _UserVersionRepository();
    songbookRepository = _SongbookRepository();
    updateSongbookPreview = _UpdateSongbookPreview();
  });

  test("When have versions and return success in api should return successful", () async {
    when(() => userVersionRepository.deleteVersionsBySongbookId(100)).thenAnswer((_) => SynchronousFuture(1));
    when(() => userVersionRepository.getUserVersionsFromSongbook(100))
        .thenAnswer((_) => SynchronousFuture([getFakeVersion()]));
    when(() => songbookRepository.deleteVersions(
          songbookId: 100,
          versionsId: any(named: "versionsId"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => updateSongbookPreview(100)).thenAnswer((invocation) => SynchronousFuture(null));

    final result =
        await ClearVersionsFromSongbook(songbookRepository, userVersionRepository, updateSongbookPreview)(100);

    expect(result.isSuccess, isTrue);
    verify(() => updateSongbookPreview(100)).called(1);
    verify(() => userVersionRepository.getUserVersionsFromSongbook(100)).called(1);
    verify(() => userVersionRepository.deleteVersionsBySongbookId(100)).called(1);
  });
}
