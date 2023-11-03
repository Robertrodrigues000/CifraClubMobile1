import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/version/repository/version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';
import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _VersionRepositoryMock extends Mock implements VersionRepository {}

class _InsertVersionDataToSongbookMock extends Mock implements InsertVersionDataToSongbook {}

void main() {
  registerFallbackValue(getFakeSongbook());
  registerFallbackValue(getFakeVersionData());

  group("When request is successful", () {
    final songbookRepository = _SongbookRepositoryMock();
    final userSongbookRepository = _UserSongbookRepositoryMock();
    final versionRepository = _VersionRepositoryMock();
    final insertVersionDataToSongbook = _InsertVersionDataToSongbookMock();
    final songbook = getFakeSongbook();

    test("and is `InsertUserSongbookNameParams` should replicate to local repository", () async {
      when(() => songbookRepository.addSongbook(
            name: songbook.name,
            isPublic: songbook.isPublic,
            createdAt: songbook.createdAt,
          )).thenAnswer((_) => SynchronousFuture(Ok((songbook: songbook, version: null))));
      when(() => userSongbookRepository.putUserSongbook(songbook)).thenAnswer((_) => SynchronousFuture(songbook.id!));

      final result = await InsertUserSongbook(
        songbookRepository,
        userSongbookRepository,
        versionRepository,
        insertVersionDataToSongbook,
      )(
        params: InsertUserSongbookWithName(
          name: songbook.name,
          isPublic: songbook.isPublic,
          createdAt: songbook.createdAt,
        ),
      );

      expect(result.isSuccess, isTrue);
      expect(result.getOrThrow().id, songbook.id);
      verify(() => userSongbookRepository.putUserSongbook(songbook)).called(1);
    });

    test("and is `InsertUserSongbookUrlParams` should replicate to local repository and save song by url", () async {
      final versionData = getFakeVersionData();
      final version = getFakeVersion();

      when(() => songbookRepository.addSongbook(
              name: songbook.name,
              isPublic: songbook.isPublic,
              createdAt: songbook.createdAt,
              versionInput: any(named: "versionInput")))
          .thenAnswer((_) => SynchronousFuture(Ok((songbook: songbook, version: version))));
      when(() => userSongbookRepository.putUserSongbook(songbook)).thenAnswer((_) => SynchronousFuture(songbook.id!));
      when(() => versionRepository.getVersionData(artistUrl: any(named: "artistUrl"), songUrl: any(named: "songUrl")))
          .thenAnswer((_) => SynchronousFuture(Ok(versionData)));
      when(() => insertVersionDataToSongbook(
            songbookId: songbook.id!,
            versionData: versionData,
            addedVersion: version,
          )).thenAnswer((_) => SynchronousFuture(const Ok(10)));

      final result = await InsertUserSongbook(
        songbookRepository,
        userSongbookRepository,
        versionRepository,
        insertVersionDataToSongbook,
      )(
        params: InsertUserSongbookWithUrl(
          name: songbook.name,
          isPublic: songbook.isPublic,
          createdAt: songbook.createdAt,
          songUrl: "songUrl",
          artistUrl: "artistUrl",
        ),
      );

      expect(result.isSuccess, isTrue);
      expect(result.getOrThrow().id, songbook.id);
      verify(() => insertVersionDataToSongbook(
            songbookId: any(named: "songbookId"),
            versionData: any(named: "versionData"),
            addedVersion: any(named: "addedVersion"),
          )).called(1);
      verify(() => userSongbookRepository.putUserSongbook(songbook)).called(1);
    });

    test("and is `InsertUserSongbookVersionParams` should replicate to local repository and save song by version",
        () async {
      final versionData = getFakeVersionData();
      final version = getFakeVersion();

      when(() => songbookRepository.addSongbook(
              name: songbook.name,
              isPublic: songbook.isPublic,
              createdAt: songbook.createdAt,
              versionInput: any(named: "versionInput")))
          .thenAnswer((_) => SynchronousFuture(Ok((songbook: songbook, version: version))));
      when(() => userSongbookRepository.putUserSongbook(songbook)).thenAnswer((_) => SynchronousFuture(songbook.id!));
      when(() => insertVersionDataToSongbook(
            songbookId: songbook.id!,
            versionData: versionData,
            addedVersion: version,
          )).thenAnswer((_) => SynchronousFuture(const Ok(10)));

      final result = await InsertUserSongbook(
        songbookRepository,
        userSongbookRepository,
        versionRepository,
        insertVersionDataToSongbook,
      )(
        params: InsertUserSongbookWithVersionData(
          name: songbook.name,
          isPublic: songbook.isPublic,
          createdAt: songbook.createdAt,
          versionData: versionData,
        ),
      );

      expect(result.isSuccess, isTrue);
      expect(result.getOrThrow().id, songbook.id);
      verify(() => insertVersionDataToSongbook(
            songbookId: any(named: "songbookId"),
            versionData: any(named: "versionData"),
            addedVersion: any(named: "addedVersion"),
          )).called(1);
      verify(() => userSongbookRepository.putUserSongbook(songbook)).called(1);
    });
  });

  group("When request fails", () {
    test("should not replicate to local repository", () async {
      final songbookRepository = _SongbookRepositoryMock();
      final userSongbookRepository = _UserSongbookRepositoryMock();

      when(() => songbookRepository.addSongbook(
            name: "new",
            isPublic: true,
            createdAt: any(named: "createdAt"),
          )).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

      final result = await InsertUserSongbook(
        songbookRepository,
        userSongbookRepository,
        _VersionRepositoryMock(),
        _InsertVersionDataToSongbookMock(),
      )(params: InsertUserSongbookWithName(name: "new"));

      expect(result.isFailure, isTrue);
      verifyNever(() => userSongbookRepository.putUserSongbook(any()));
    });
  });

  test("and is url params should not replace in local repository", () async {
    final songbookRepository = _SongbookRepositoryMock();
    final userSongbookRepository = _UserSongbookRepositoryMock();
    final versionRepository = _VersionRepositoryMock();
    final insertVersionDataToSongbook = _InsertVersionDataToSongbookMock();
    final songbook = getFakeSongbook();

    when(() => versionRepository.getVersionData(artistUrl: any(named: "artistUrl"), songUrl: any(named: "songUrl")))
        .thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

    final result = await InsertUserSongbook(
      songbookRepository,
      userSongbookRepository,
      versionRepository,
      insertVersionDataToSongbook,
    )(
      params: InsertUserSongbookWithUrl(
        name: songbook.name,
        isPublic: songbook.isPublic,
        createdAt: songbook.createdAt,
        songUrl: "songUrl",
        artistUrl: "artistUrl",
      ),
    );

    expect(result.isFailure, isTrue);
    verifyNever(() => userSongbookRepository.putUserSongbook(any()));
    verifyNever(() => insertVersionDataToSongbook(
          songbookId: any(named: "songbookId"),
          versionData: any(named: "versionData"),
          addedVersion: any(named: "addedVersion"),
        ));
  });
}
