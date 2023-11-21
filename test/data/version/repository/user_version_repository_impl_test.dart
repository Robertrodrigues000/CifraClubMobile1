import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/models/user_version/user_recent_version_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_dto.dart';
import 'package:cifraclub/data/version/repository/user_version_repository_impl.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionDataSourceMock extends Mock implements UserVersionDataSource {}

class _UserVersionDtoMock extends Mock implements UserVersionDto {}

class _UserRecentVersionDtoMock extends Mock implements UserRecentVersionDto {}

class _UserVersionDataDtoFake extends Fake implements UserVersionDataDto {}

void main() {
  setUpAll(() {
    registerFallbackValue(_UserVersionDataDtoFake());
  });

  test("When `clearAllVersion` is called should clear user versions", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(userVersionDataSource.clearAllVersions).thenAnswer((_) => SynchronousFuture(null));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    await userVersionRepository.clearAllVersions();

    verify(userVersionDataSource.clearAllVersions).called(1);
  });

  test("When `getTotalSongbookVersions` is called should return stream of count versions in a songbook", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.getTotalSongbookVersions(1)).thenAnswer((_) => BehaviorSubject.seeded(10));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final countVersionsStream = userVersionRepository.getTotalSongbookVersions(1);

    verify(() => userVersionDataSource.getTotalSongbookVersions(1)).called(1);
    expect(countVersionsStream, emitsInOrder([10]));
  });

  group("When `getUserVersionsFromSongbook` is called", () {
    test("When is recent songbook should return list of versions", () async {
      final userVersionDto = _UserRecentVersionDtoMock();
      final fakeVersion = getFakeVersion();
      when(userVersionDto.toDomain).thenReturn(fakeVersion);

      final userVersionDataSource = _UserVersionDataSourceMock();
      when(userVersionDataSource.getVersionsFromRecentSongbook).thenAnswer((_) => SynchronousFuture([userVersionDto]));

      final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

      final versions = await userVersionRepository.getUserVersionsFromSongbook(1);

      verify(userVersionDataSource.getVersionsFromRecentSongbook).called(1);
      verify(userVersionDto.toDomain).called(1);
      expect(versions, isNotNull);
      expect(versions, [fakeVersion]);
    });

    test("When is not recent songbook should return list of versions", () async {
      final userVersionDto = _UserVersionDtoMock();
      final fakeVersion = getFakeVersion();
      when(userVersionDto.toDomain).thenReturn(fakeVersion);

      final userVersionDataSource = _UserVersionDataSourceMock();
      when(() => userVersionDataSource.getVersionsFromSongbook(10))
          .thenAnswer((_) => SynchronousFuture([userVersionDto]));

      final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

      final versions = await userVersionRepository.getUserVersionsFromSongbook(10);

      verify(() => userVersionDataSource.getVersionsFromSongbook(10)).called(1);
      verify(userVersionDto.toDomain).called(1);
      expect(versions, isNotNull);
      expect(versions, [fakeVersion]);
    });
  });

  test("When `putVersionsToSongbook` is called should return ids of added versions", () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    final versionsIds = versions.map((e) => e.localDatabaseId!).toList();

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.putVersionsToSongbook(any())).thenAnswer((_) => SynchronousFuture(versionsIds));
    when(() => userVersionDataSource.getTotalSongbookVersions(any())).thenAnswer((_) => BehaviorSubject.seeded(0));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final deletedIds = await userVersionRepository.putVersionsToSongbook(versions, 10);
    final domainVersions = versions.map((e) => UserVersionDto.fromDomain(e, 10)).toList();

    verify(() => userVersionDataSource.putVersionsToSongbook(domainVersions)).called(1);
    expect(deletedIds, versionsIds);
  });

  test("When `putVersionsToSongbook` is called to add versions to recents, should return ids of added versions",
      () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    final versionsIds = versions.map((e) => e.localDatabaseId!).toList();

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.putVersionsToSongbook(any())).thenAnswer((_) => SynchronousFuture(versionsIds));
    when(() => userVersionDataSource.getTotalSongbookVersions(any())).thenAnswer((_) => BehaviorSubject.seeded(0));
    when(() => userVersionDataSource.putVersionsToRecentSongbook(any()))
        .thenAnswer((_) => SynchronousFuture(versionsIds));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final deletedIds = await userVersionRepository.putVersionsToSongbook(versions, 1);
    final domainVersions = versions.map(UserRecentVersionDto.fromDomain).toList();

    verify(() => userVersionDataSource.putVersionsToRecentSongbook(domainVersions)).called(1);
    expect(deletedIds, versionsIds);
  });

  test("When `addVersionToRecentSongbook` is called should return ids of versions deleted", () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    final versionsIds = versions.map((e) => e.remoteDatabaseId!).toList();

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.putVersionsToRecentSongbook(any()))
        .thenAnswer((_) => SynchronousFuture(versionsIds));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final deletedIds = await userVersionRepository.putVersionsToRecentSongbook(versions);
    final domainVersions = versions.map(UserRecentVersionDto.fromDomain).toList();

    verify(() => userVersionDataSource.putVersionsToRecentSongbook(domainVersions)).called(1);
    expect(deletedIds, versionsIds);
  });

  test("When `getImagesPreview` is called should return list of images", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.getImagesPreview(1)).thenAnswer((_) => SynchronousFuture(["image1", "image2"]));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);
    final images = await userVersionRepository.getImagesPreview(1);

    expect(images, ["image1", "image2"]);
    verify(() => userVersionDataSource.getImagesPreview(1)).called(1);
  });

  test("When `deleteVersionsBySongbookId` is called should return quantity of deleted versions", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.deleteVersions(4)).thenAnswer((_) => SynchronousFuture(2));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);
    final countVersionsDeleted = await userVersionRepository.deleteVersionsBySongbookId(4);

    expect(countVersionsDeleted, 2);
    verify(() => userVersionDataSource.deleteVersions(4)).called(1);
  });

  test("When `deleteVersionsBySongbookId` is called and is recent songbook should return quantity of deleted versions",
      () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(userVersionDataSource.deleteRecentVersions).thenAnswer((_) => SynchronousFuture(2));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);
    final countVersionsDeleted = await userVersionRepository.deleteVersionsBySongbookId(1);

    expect(countVersionsDeleted, 2);
    verify(userVersionDataSource.deleteRecentVersions).called(1);
  });

  test("When `deleteVersionsById` is called should return quantity of deleted songs", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.deleteVersionsById([1, 2], any())).thenAnswer((_) => SynchronousFuture(2));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);
    final countVersionsDeleted = await userVersionRepository.deleteVersionsById([1, 2], 1);

    expect(countVersionsDeleted, 2);
    verify(() => userVersionDataSource.deleteVersionsById([1, 2], 1)).called(1);
  });

  test("When `deleteVersionBySongId` is called should return true if version is deleted", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.deleteVersionBySongId(1, 2)).thenAnswer((_) => SynchronousFuture(true));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);
    final isVersionDeleted = await userVersionRepository.deleteVersionBySongId(1, 2);

    expect(isVersionDeleted, true);
    verify(() => userVersionDataSource.deleteVersionBySongId(1, 2)).called(1);
  });

  test("When `getUserVersionStreamFromSongbook` is called should return list of versions", () async {
    final userVersionDto = _UserVersionDtoMock();
    final fakeVersion = getFakeVersion();
    when(userVersionDto.toDomain).thenReturn(fakeVersion);

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.getVersionsStreamFromSongbook(10))
        .thenAnswer((_) => BehaviorSubject.seeded([userVersionDto]));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final versions = userVersionRepository.getVersionsStreamFromSongbook(10);

    expect(versions, emits([fakeVersion]));
    verify(() => userVersionDataSource.getVersionsStreamFromSongbook(10)).called(1);
  });

  test("When `getVersionsStreamFromRecentSongbook` is called and is recent songbook should return list of versions",
      () async {
    final userVersionDto = _UserRecentVersionDtoMock();
    final fakeVersion = getFakeVersion();
    when(userVersionDto.toDomain).thenReturn(fakeVersion);

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(userVersionDataSource.getVersionsStreamFromRecentSongbook)
        .thenAnswer((_) => BehaviorSubject.seeded([userVersionDto]));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final versions = userVersionRepository.getVersionsStreamFromSongbook(1);

    expect(versions, emits([fakeVersion]));
    verify(userVersionDataSource.getVersionsStreamFromRecentSongbook).called(1);
  });

  test("When `updateVersionsToSongbook` is called should return ids of versions updated", () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    final versionsIds = versions.map((e) => e.remoteDatabaseId!).toList();

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.putVersionsToSongbook(any())).thenAnswer((_) => SynchronousFuture(versionsIds));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final updatedIds = await userVersionRepository.updateVersionsToSongbook(versions, 1);
    final domainVersions = versions.map((e) => UserVersionDto.fromDomain(e, 1)).toList();

    verify(() => userVersionDataSource.putVersionsToSongbook(domainVersions)).called(1);
    expect(updatedIds, versionsIds);
  });

  test("When `getIsFavoriteVersionBySongIdStream` is called should return stream of favorite version", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.getIsFavoriteVersionBySongIdStream(1))
        .thenAnswer((_) => BehaviorSubject.seeded(true));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final isFavorite = userVersionRepository.getIsFavoriteVersionBySongIdStream(1);

    verify(() => userVersionDataSource.getIsFavoriteVersionBySongIdStream(1)).called(1);
    expect(isFavorite, emitsInOrder([true]));
  });

  test("When `addVersionData` is called should return ids of versions deleted", () async {
    final versionData = getFakeVersionData();

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.addVersionData(any())).thenAnswer((_) => SynchronousFuture(1));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final addedId =
        await userVersionRepository.addVersionData(versionData: versionData, versionLocalDatabaseId: 1, songbookId: 2);

    expect(addedId, 1);
  });

  test("when getLocalDatabaseIdFromSongIdInRecentSongbook is called, the datasource method should be called", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();

    when(() => userVersionDataSource.getLocalDatabaseIdFromSongIdInRecentSongbook(any()))
        .thenAnswer((_) => SynchronousFuture(42));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    var localDatabaseId = await userVersionRepository.getLocalDatabaseIdFromSongIdInRecentSongbook(10);
    expect(localDatabaseId, 42);
    verify(() => userVersionDataSource.getLocalDatabaseIdFromSongIdInRecentSongbook(10)).called(1);
  });

  test("when getTotalRecentVersions is called, the datasource method should be called", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();

    when(userVersionDataSource.getTotalRecentVersions).thenAnswer((_) => SynchronousFuture(42));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    var recentCount = await userVersionRepository.getTotalRecentVersions();
    expect(recentCount, 42);
    verify(userVersionDataSource.getTotalRecentVersions).called(1);
  });

  test("when deleteOldestRecentVersion is called, the datasource method should be called", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();

    when(userVersionDataSource.deleteOldestRecentVersion).thenAnswer((_) => SynchronousFuture(true));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    var wasRecentDeleted = await userVersionRepository.deleteOldestRecentVersion();
    expect(wasRecentDeleted, true);
    verify(userVersionDataSource.deleteOldestRecentVersion).called(1);
  });

  test("when getIsVersionOnSongbook", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.getIsVersionOnSongbook(any(), any())).thenAnswer((_) => SynchronousFuture(false));
    final repository = UserVersionRepositoryImpl(userVersionDataSource);

    var result = await repository.getIsVersionOnSongbook(ListType.favorites.localId, 123);
    expect(result, isFalse);
  });

  test("when getVersionBySongId should return version", () async {
    final userVersionDto = _UserVersionDtoMock();
    final fakeVersion = getFakeVersion();
    final userVersionDataSource = _UserVersionDataSourceMock();

    when(userVersionDto.toDomain).thenReturn(fakeVersion);
    when(() => userVersionDataSource.getVersionBySongId(any(), any()))
        .thenAnswer((_) => SynchronousFuture(userVersionDto));

    final repository = UserVersionRepositoryImpl(userVersionDataSource);
    var result = await repository.getVersionBySongId(15, 123);

    expect(result?.songId, fakeVersion.songId);
    expect(result?.remoteDatabaseId, fakeVersion.remoteDatabaseId);
    verify(userVersionDto.toDomain).called(1);
  });

  test("when deleteVersionFromRecent is called, the datasource method should be called", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    registerFallbackValue(Instrument.guitar);

    when(() => userVersionDataSource.deleteVersionFromRecent(any(), any())).thenAnswer((_) => SynchronousFuture(1));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    var songsDeleted = await userVersionRepository.deleteVersionFromRecent(2, Instrument.guitar);
    expect(songsDeleted, 1);
    verify(() => userVersionDataSource.deleteVersionFromRecent(2, Instrument.guitar)).called(1);
  });
}
