import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_recents.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _InsertVersionDataToSongbookMock extends Mock implements InsertVersionDataToSongbook {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

void main() {
  registerFallbackValue(getFakeVersionData());
  group("When InsertVersionDataToRecents is called", () {
    final insertVersionDataToSongbook = _InsertVersionDataToSongbookMock();
    when(() => insertVersionDataToSongbook(
          versionData: any(named: "versionData"),
          songbookId: any(named: "songbookId"),
          versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(42)));

    final userVersionRepository = _UserVersionRepositoryMock();
    test('if the song dosn`t exist in the list, it must be created', () async {
      when(
        () => userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(any()),
      ).thenAnswer((_) => SynchronousFuture(null));
      when(
        userVersionRepository.getTotalRecentVersions,
      ).thenAnswer((_) => SynchronousFuture(0));
      when(
        userVersionRepository.deleteOldestRecentVersion,
      ).thenAnswer((_) => SynchronousFuture(false));

      var insertVersionDataToRecents = InsertVersionDataToRecents(insertVersionDataToSongbook, userVersionRepository);
      var versionData = getFakeVersionData();
      await insertVersionDataToRecents(versionData: versionData);

      verify(() => userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(versionData.song.songId))
          .called(1);
      verify(() => insertVersionDataToSongbook(versionData: versionData, songbookId: 1, versionLocalDatabaseId: null))
          .called(1);
      verifyNever(userVersionRepository.deleteOldestRecentVersion);
    });

    test('if the song already exist in the list, it must be overwritten', () async {
      when(
        () => userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(any()),
      ).thenAnswer((_) => SynchronousFuture(30));
      when(
        userVersionRepository.getTotalRecentVersions,
      ).thenAnswer((_) => SynchronousFuture(0));
      when(
        userVersionRepository.deleteOldestRecentVersion,
      ).thenAnswer((_) => SynchronousFuture(false));

      var insertVersionDataToRecents = InsertVersionDataToRecents(insertVersionDataToSongbook, userVersionRepository);
      var versionData = getFakeVersionData();
      await insertVersionDataToRecents(versionData: versionData);

      verify(() => userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(versionData.song.songId))
          .called(1);
      verify(() => insertVersionDataToSongbook(versionData: versionData, songbookId: 1, versionLocalDatabaseId: 30))
          .called(1);
      verifyNever(userVersionRepository.deleteOldestRecentVersion);
    });

    test('if there is already the maximum quantity of recent versions, the last should be deleted', () async {
      when(
        () => userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(any()),
      ).thenAnswer((_) => SynchronousFuture(null));
      when(
        userVersionRepository.getTotalRecentVersions,
      ).thenAnswer((_) => SynchronousFuture(51));
      when(
        userVersionRepository.deleteOldestRecentVersion,
      ).thenAnswer((_) => SynchronousFuture(true));

      var insertVersionDataToRecents = InsertVersionDataToRecents(insertVersionDataToSongbook, userVersionRepository);
      var versionData = getFakeVersionData();
      await insertVersionDataToRecents(versionData: versionData);

      verify(() => userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(versionData.song.songId))
          .called(1);
      verify(() => insertVersionDataToSongbook(versionData: versionData, songbookId: 1, versionLocalDatabaseId: null))
          .called(1);
      verify(userVersionRepository.deleteOldestRecentVersion).called(1);
    });
  });
}
