import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/refresh_all_songbooks.dart';
import 'package:cifraclub/domain/version/repository/version_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_versions_mock.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _VersionRepositoryMock extends Mock implements VersionRepository {}

class _UpdateSongbookPreviewMock extends Mock implements UpdateSongbookPreview {}

void main() {
  setUpAll(() {
    registerFallbackValue(getFakeSongbook());
    registerFallbackValue(getFakeVersionData());
  });

  group("When call `RefreshAllSongbooks` use case", () {
    test("When have songbook in local DB and dont have in remote should delete local songbook", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final versionRepository = _VersionRepositoryMock();

      final localSongbook = getFakeSongbook(lastUpdated: DateTime(2021), id: 11);
      final songbookVersions = getFakeSongbookVersions(lastUpdated: DateTime(2022), id: 10, versions: []);

      //Pegar os songbooks locais e remotos e as versions remotas
      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Ok([songbookVersions])));
      when(userSongbookRepository.getAllUserSongbooks).thenAnswer((_) => BehaviorSubject.seeded([localSongbook]));

      //Deletar songbook e version do local DB
      when(() => songbookRepository.deleteSongbook(any())).thenAnswer((_) => Future.value(const Ok(null)));
      when(() => userVersionRepository.deleteVersionsBySongbookId(any())).thenAnswer((_) => Future.value(1));
      when(() => userSongbookRepository.deleteUserSongbook(any())).thenAnswer((_) => Future.value(true));

      //Pegar as versions locais
      when(() => userVersionRepository.getUserVersionsFromSongbook(any())).thenAnswer((_) => SynchronousFuture([]));

      //Enviar songbook para o local DB
      when(() => userSongbookRepository.putUserSongbook(any())).thenAnswer((invocation) => SynchronousFuture(1));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository, userVersionRepository,
          versionRepository, _UpdateSongbookPreviewMock())();

      expect(result.isSuccess, isTrue);
      verify(() => songbookRepository.deleteSongbook(localSongbook.id!)).called(1);
      verify(() => userVersionRepository.deleteVersionsBySongbookId(localSongbook.id!)).called(1);
      verify(() => userSongbookRepository.deleteUserSongbook(localSongbook.id!)).called(1);
    });

    test(
        "When dont have songbook in local and have in remote should add remote to local and all versions and version datas",
        () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final versionRepository = _VersionRepositoryMock();

      final songbookVersions = getFakeSongbookVersions();

      //Pegar os songbooks locais e remotos e as versions remotas
      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Ok([songbookVersions])));
      when(userSongbookRepository.getAllUserSongbooks).thenAnswer((_) => BehaviorSubject.seeded([]));

      //Enviar songbook para o local DB
      when(() => userSongbookRepository.putUserSongbook(any())).thenAnswer((invocation) => SynchronousFuture(1));

      //Fluxo de add versions e versions datas
      when(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).thenAnswer((_) => Future.value(Ok(getFakeVersionData())));
      when(() => userVersionRepository.putVersionsToSongbook(any(), any()))
          .thenAnswer((_) => SynchronousFuture([1, 2]));
      when(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).thenAnswer((_) => SynchronousFuture(1));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository, userVersionRepository,
          versionRepository, _UpdateSongbookPreviewMock())();

      expect(result.isSuccess, isTrue);

      //Add Songbook
      verify(() => userSongbookRepository.putUserSongbook(songbookVersions.songbook)).called(1);

      verify(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).called(songbookVersions.versions.length);

      //Add Versions
      verify(() => userVersionRepository.putVersionsToSongbook(
            songbookVersions.versions,
            songbookVersions.songbook.id!,
          )).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).called(songbookVersions.versions.length);
    });

    test(
        "When the local songbook has a dateTime greater than the remote songbook should add version that dont have in local songbook",
        () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final versionRepository = _VersionRepositoryMock();
      final updateSongbookPreview = _UpdateSongbookPreviewMock();

      final version = getFakeVersion(remoteDatabaseId: 1);
      final versionsToAdd = [
        getFakeVersion(remoteDatabaseId: 2),
        getFakeVersion(remoteDatabaseId: 3),
        getFakeVersion(remoteDatabaseId: 4),
      ];
      final songbookVersions = getFakeSongbookVersions(
        lastUpdated: DateTime(2020),
        versions: [version, ...versionsToAdd],
      );
      final userSongbook = getFakeSongbook(lastUpdated: DateTime(2021), id: songbookVersions.songbook.id);

      //Pegar os songbooks locais e remotos e as versions remotas
      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Ok([songbookVersions])));
      when(userSongbookRepository.getAllUserSongbooks).thenAnswer((_) => BehaviorSubject.seeded([userSongbook]));

      //Pegar as versions locais
      when(() => userVersionRepository.getUserVersionsFromSongbook(any()))
          .thenAnswer((_) => SynchronousFuture([version]));

      //Fluxo de add versions e versions datas
      when(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).thenAnswer((_) => Future.value(Ok(getFakeVersionData())));
      when(() => userVersionRepository.putVersionsToSongbook(any(), any()))
          .thenAnswer((_) => SynchronousFuture([1, 2, 3]));
      when(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).thenAnswer((_) => SynchronousFuture(1));

      //Atualizar o count de songs do songbook
      when(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId")))
          .thenAnswer((_) => SynchronousFuture(1));

      when(() => updateSongbookPreview(any())).thenAnswer((invocation) => Future.value(null));

      final result = await RefreshAllSongbooks(
        songbookRepository,
        userSongbookRepository,
        userVersionRepository,
        versionRepository,
        updateSongbookPreview,
      )();

      expect(result.isSuccess, isTrue);
      verifyNever(() => userSongbookRepository.putUserSongbook(any()));

      verify(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).called(3);

      //Add Versions
      verify(() => userVersionRepository.putVersionsToSongbook(
            versionsToAdd,
            songbookVersions.songbook.id!,
          )).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).called(3);

      verify(() => userSongbookRepository.updateTotalSongs(songbookId: songbookVersions.songbook.id!)).called(1);
      verify(() => updateSongbookPreview(songbookVersions.songbook.id!)).called(1);
    });

    test(
        "When the local songbook has a dateTime smaller than the remote songbook should add version that dont have in local songbook",
        () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final versionRepository = _VersionRepositoryMock();

      final version = getFakeVersion(remoteDatabaseId: 1);
      final versionsToAdd = [
        getFakeVersion(remoteDatabaseId: 2),
        getFakeVersion(remoteDatabaseId: 3),
        getFakeVersion(remoteDatabaseId: 4),
      ];
      final versionToDelete = [
        getFakeVersion(remoteDatabaseId: 5),
        getFakeVersion(remoteDatabaseId: 6),
      ];
      final orderedVersions = [
        getFakeVersion(order: 1, remoteDatabaseId: 7),
        getFakeVersion(order: 0, remoteDatabaseId: 8),
      ];
      final songbookVersions = getFakeSongbookVersions(
        lastUpdated: DateTime(2021),
        versions: [version, ...versionsToAdd, ...orderedVersions],
      );
      final localVersions = [
        ...versionToDelete,
        version,
        ...orderedVersions.mapIndexed((index, e) => e.copyWith(order: index)).toList()
      ];
      final userSongbook = getFakeSongbook(lastUpdated: DateTime(2020), id: songbookVersions.songbook.id);

      //Pegar os songbooks locais e remotos e as versions remotas
      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Ok([songbookVersions])));
      when(userSongbookRepository.getAllUserSongbooks).thenAnswer((_) => BehaviorSubject.seeded([userSongbook]));

      //Pegar as versions locais
      when(() => userVersionRepository.getUserVersionsFromSongbook(any()))
          .thenAnswer((_) => SynchronousFuture(localVersions));

      //Atualizar songbook e versions e deletar versions
      when(() => userSongbookRepository.putUserSongbook(any())).thenAnswer((invocation) => SynchronousFuture(1));
      when(() => userVersionRepository.deleteVersionsById(any(), any()))
          .thenAnswer((invocation) => SynchronousFuture(1));
      when(() => userVersionRepository.putVersionsToSongbook(any(), any()))
          .thenAnswer((invocation) => SynchronousFuture([1, 2]));

      //Fluxo de add versions e versions datas
      when(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).thenAnswer((_) => Future.value(Ok(getFakeVersionData())));
      when(() => userVersionRepository.putVersionsToSongbook(any(), any()))
          .thenAnswer((_) => SynchronousFuture([1, 2, 3]));
      when(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).thenAnswer((_) => SynchronousFuture(1));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository, userVersionRepository,
          versionRepository, _UpdateSongbookPreviewMock())();

      expect(result.isSuccess, isTrue);
      verify(() => userSongbookRepository.putUserSongbook(songbookVersions.songbook)).called(1);

      //Deleted Versions
      verify(() => userVersionRepository.deleteVersionsById(
            versionToDelete.map((e) => e.localDatabaseId!).toList(),
            songbookVersions.songbook.id!,
          )).called(1);

      //Updated order versions
      verify(() => userVersionRepository.putVersionsToSongbook(
            orderedVersions,
            songbookVersions.songbook.id!,
          )).called(1);

      verify(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).called(3);

      //Add Versions
      verify(() => userVersionRepository.putVersionsToSongbook(
            versionsToAdd,
            songbookVersions.songbook.id!,
          )).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).called(3);
    });

    test(
        "When the local songbook has a dateTime smaller than the remote songbook should update version with changed config",
        () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final versionRepository = _VersionRepositoryMock();

      final version = [
        getFakeVersion(remoteDatabaseId: 1, localDatabaseId: 1, capo: Capo.capo1),
        getFakeVersion(remoteDatabaseId: 2, localDatabaseId: 2, capo: Capo.capo2),
        getFakeVersion(remoteDatabaseId: 3, localDatabaseId: 3, capo: Capo.capo3),
      ];

      final songbookVersions = getFakeSongbookVersions(
        lastUpdated: DateTime(2021),
        versions: version,
      );
      final localVersions = [
        ...version.map((e) => e.copyWith(capo: Capo.capo10)).toList(),
      ];
      final userSongbook = getFakeSongbook(lastUpdated: DateTime(2020), id: songbookVersions.songbook.id);

      //Pegar os songbooks locais e remotos e as versions remotas
      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Ok([songbookVersions])));
      when(userSongbookRepository.getAllUserSongbooks).thenAnswer((_) => BehaviorSubject.seeded([userSongbook]));

      //Pegar as versions locais
      when(() => userVersionRepository.getUserVersionsFromSongbook(any()))
          .thenAnswer((_) => SynchronousFuture(localVersions));

      //Atualizar songbook
      when(() => userSongbookRepository.putUserSongbook(any())).thenAnswer((invocation) => SynchronousFuture(1));

      //Fluxo de atualizar versions e versions datas
      when(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).thenAnswer((_) => Future.value(Ok(getFakeVersionData())));
      when(() => userVersionRepository.putVersionsToSongbook(any(), any()))
          .thenAnswer((_) => SynchronousFuture([1, 2, 3]));
      when(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).thenAnswer((_) => SynchronousFuture(1));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository, userVersionRepository,
          versionRepository, _UpdateSongbookPreviewMock())();

      expect(result.isSuccess, isTrue);
      verify(() => userSongbookRepository.putUserSongbook(songbookVersions.songbook)).called(1);

      //Deleted Versions
      verifyNever(() => userVersionRepository.deleteVersionsById(any(), any()));

      verify(() => versionRepository.getVersionDataByVersionId(
            versionId: any(named: "versionId"),
            apiType: any(named: "apiType"),
          )).called(3);

      //Add Versions
      verify(() => userVersionRepository.putVersionsToSongbook(
            any(),
            songbookVersions.songbook.id!,
          )).called(1);
      verify(() => userVersionRepository.addVersionData(
            versionData: any(named: "versionData"),
            versionLocalDatabaseId: any(named: "versionLocalDatabaseId"),
            songbookId: any(named: "songbookId"),
          )).called(3);
    });
  });

  group("When request fails", () {
    test("should not replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();
      final userVersionRepository = _UserVersionRepositoryMock();
      final updateSongbookPreview = _VersionRepositoryMock();

      when(songbookRepository.getAllSongbooks).thenAnswer((_) => Future.value(Err(ConnectionError())));

      final result = await RefreshAllSongbooks(songbookRepository, userSongbookRepository, userVersionRepository,
          updateSongbookPreview, _UpdateSongbookPreviewMock())();

      expect(result.isFailure, isTrue);
      verifyNever(() => userSongbookRepository.setUserSongbooks(any()));
    });
  });
}
