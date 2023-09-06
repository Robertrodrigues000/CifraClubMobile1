import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/sort_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_last_updated.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UpdateSongbookLastUpdatedMock extends Mock implements UpdateSongbookLastUpdated {}

void main() {
  test("When is success should save in correctly order", () async {
    final songbook = getFakeSongbook();
    final versions = [getFakeVersion(), getFakeVersion()];

    final songbookRepository = _SongbookRepositoryMock();
    when(() => songbookRepository.sortVersionFromSongbook(
          songbookId: any(named: "songbookId"),
          versionsId: any(named: "versionsId"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    final userVersionRepository = _UserVersionRepositoryMock();
    when(() => userVersionRepository.updateVersionsToSongbook(any(), any()))
        .thenAnswer((_) => SynchronousFuture([versions.first.remoteDatabaseId!, versions.last.remoteDatabaseId!]));

    final updateSongbookLastUpdated = _UpdateSongbookLastUpdatedMock();
    when(() => updateSongbookLastUpdated(any())).thenAnswer((invocation) => SynchronousFuture(0));

    await SortVersionsFromSongbook(songbookRepository, userVersionRepository, updateSongbookLastUpdated)(
        songbook.id!, versions);

    verify(() => songbookRepository.sortVersionFromSongbook(
          songbookId: songbook.id!,
          versionsId: [versions.first.remoteDatabaseId!, versions.last.remoteDatabaseId!],
        )).called(1);

    final orderedVersion = [
      versions.first.copyWith(order: 0),
      versions.last.copyWith(order: 1),
    ];

    verify(() => updateSongbookLastUpdated(songbook.id!)).called(1);
    verify(() => userVersionRepository.updateVersionsToSongbook(orderedVersion, songbook.id!)).called(1);
  });

  test("When fails should return error", () async {
    final songbook = getFakeSongbook();
    final versions = [getFakeVersion(), getFakeVersion()];

    final songbookRepository = _SongbookRepositoryMock();
    when(() => songbookRepository.sortVersionFromSongbook(
          songbookId: any(named: "songbookId"),
          versionsId: any(named: "versionsId"),
        )).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final userVersionRepository = _UserVersionRepositoryMock();
    final updateSongbookLastUpdated = _UpdateSongbookLastUpdatedMock();

    final result = await SortVersionsFromSongbook(songbookRepository, userVersionRepository, updateSongbookLastUpdated)(
        songbook.id!, versions);

    verify(() => songbookRepository.sortVersionFromSongbook(
          songbookId: songbook.id!,
          versionsId: [versions.first.remoteDatabaseId!, versions.last.remoteDatabaseId!],
        )).called(1);

    verifyNever(() => userVersionRepository.updateVersionsToSongbook(any(), any()));
    verifyNever(() => updateSongbookLastUpdated(any()));

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));
  });
}
