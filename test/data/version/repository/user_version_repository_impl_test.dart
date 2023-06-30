import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/models/user_version_dto.dart';
import 'package:cifraclub/data/version/repository/user_version_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionDataSourceMock extends Mock implements UserVersionDataSource {}

class _UserVersionDtoMock extends Mock implements UserVersionDto {}

void main() {
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

  test("When `getUserVersionsFromSongbook` is called should return list of versions", () async {
    final userVersionDto = _UserVersionDtoMock();
    final fakeVersion = getFakeVersion();
    when(userVersionDto.toDomain).thenReturn(fakeVersion);

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.getVersionsFromSongbook(1)).thenAnswer((_) => SynchronousFuture([userVersionDto]));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final versions = await userVersionRepository.getUserVersionsFromSongbook(1);

    verify(() => userVersionDataSource.getVersionsFromSongbook(1)).called(1);
    verify(userVersionDto.toDomain).called(1);
    expect(versions, isNotNull);
    expect(versions, [fakeVersion]);
  });

  test("When `addVersionsToSongbook` is called should return ids of versions deleted", () async {
    final versions = [getFakeVersion(), getFakeVersion()];
    final versionsIds = versions.map((e) => e.localDatabaseID!).toList();

    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.addVersionsToSongbook(any())).thenAnswer((_) => SynchronousFuture(versionsIds));

    final userVersionRepository = UserVersionRepositoryImpl(userVersionDataSource);

    final deletedIds = await userVersionRepository.addVersionToSongbook(versions, 1);
    final domainVersions = versions.map((e) => UserVersionDto.fromDomain(e, 1)).toList();

    verify(() => userVersionDataSource.addVersionsToSongbook(domainVersions)).called(1);
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

  test("When `deleteSongsById` is called should return quantity of deleted songs", () async {
    final userVersionDataSource = _UserVersionDataSourceMock();
    when(() => userVersionDataSource.deleteVersionsById([1, 2])).thenAnswer((_) => SynchronousFuture(2));

    final userCifraRepository = UserVersionRepositoryImpl(userVersionDataSource);
    final countCifrasDeleted = await userCifraRepository.deleteVersionsById([1, 2]);

    expect(countCifrasDeleted, 2);
    verify(() => userVersionDataSource.deleteVersionsById([1, 2])).called(1);
  });
}
