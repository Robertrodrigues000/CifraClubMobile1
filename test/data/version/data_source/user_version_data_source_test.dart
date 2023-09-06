import 'dart:async';

import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/models/user_version/user_recent_version_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_song_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_data_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_dto.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../shared_mocks/domain/version/models/version_data_mock.dart';
import '../../../test_helpers/isar_test_module.dart';

void main() {
  late Isar isar;

  late UserVersionDataSource userVersionDataSource;

  setUpAll(() async {
    await IsarTestModule.initializeCore();
  });

  setUp(() async {
    isar = await IsarTestModule.getIsar();
    userVersionDataSource = UserVersionDataSource(isar);
  });

  tearDown(() {
    isar.close(deleteFromDisk: true);
  });

  UserVersionDto getUserVersionDto({
    int? localDatabaseId,
    UserVersionArtistDto? userVersionArtistDto,
    int? songbookId,
    String? artistImage,
    int? songId,
    int? versionLocalDatabaseId,
  }) =>
      UserVersionDto(
        localDatabaseId: localDatabaseId ?? faker.randomGenerator.integer(10000),
        remoteDatabaseId: faker.randomGenerator.integer(10000),
        name: faker.food.cuisine(),
        songUrl: faker.animal.name(),
        key: faker.animal.name(),
        type: faker.randomGenerator.integer(10000),
        songId: songId ?? faker.randomGenerator.integer(10000),
        songbookId: songbookId ?? faker.randomGenerator.integer(10000),
        artist: userVersionArtistDto ?? UserVersionArtistDto(),
        artistImage: artistImage,
        versionId: faker.randomGenerator.integer(10000),
        order: faker.randomGenerator.integer(10000),
      );

  UserRecentVersionDto getUserRecentVersionDto({
    UserVersionArtistDto? userVersionArtistDto,
    String? artistImage,
    int? localDatabaseId,
  }) =>
      UserRecentVersionDto(
        localDatabaseId: localDatabaseId ?? faker.randomGenerator.integer(10000),
        name: faker.food.cuisine(),
        songUrl: faker.animal.name(),
        key: faker.animal.name(),
        instrument: Instrument.bass,
        songId: faker.randomGenerator.integer(10000),
        artist: userVersionArtistDto ?? UserVersionArtistDto(),
        artistImage: artistImage,
        versionId: faker.randomGenerator.integer(10000),
      );

  group("when getVersionsFromSongbook is called", () {
    test("and songbook has versions should return songs list", () async {
      final fakeSongbookId = faker.randomGenerator.integer(1000);

      final versions = [
        getUserVersionDto(songbookId: fakeSongbookId),
      ];

      await isar.writeTxn(
        () async {
          await isar.userVersionDtos.putAll(versions);
        },
      );

      final result = await userVersionDataSource.getVersionsFromSongbook(fakeSongbookId);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result.length, 1);
      expect(result.first.name, versions.first.name);
    });

    test("when user doesn't have songs in songbook should return versions list", () async {
      final fakeSongbookId = faker.randomGenerator.integer(1000);

      final result = await userVersionDataSource.getVersionsFromSongbook(fakeSongbookId);

      expect(result, []);
    });
  });

  test("when getVersionsFromSongbook is called should return songs list", () async {
    final versions = [
      getUserRecentVersionDto(),
    ];

    await isar.writeTxn(
      () async {
        await isar.userRecentVersionDtos.putAll(versions);
      },
    );

    final result = await userVersionDataSource.getVersionsFromRecentSongbook();

    expect(result, isNotNull);
    expect(result, isNotEmpty);
    expect(result.length, 1);
    expect(result.first, versions.first);
  });

  test("When 'addVersionsToSongbook' is called should save versions to local db", () async {
    final versions = [
      getUserVersionDto(localDatabaseId: 1),
      getUserVersionDto(localDatabaseId: 2),
    ];

    final result = await userVersionDataSource.putVersionsToSongbook(versions);

    late List<UserVersionDto> localVersions;
    await isar.txn(() async {
      localVersions = await isar.userVersionDtos.where().findAll();
    });

    expect(result, [versions[0].localDatabaseId, versions[1].localDatabaseId]);
    // toSet para comparar as 2 listas que podem vir em ordens diferentes
    expect(localVersions.toSet(), versions.toSet());
  });

  test("When 'addVersionsToRecentSongbook' is called should save versions to local db", () async {
    final recentVersions = [
      getUserRecentVersionDto(localDatabaseId: 1),
      getUserRecentVersionDto(localDatabaseId: 2),
    ];

    final result = await userVersionDataSource.putVersionsToRecentSongbook(recentVersions);

    late List<UserRecentVersionDto> localVersions;
    await isar.txn(() async {
      localVersions = await isar.userRecentVersionDtos.where().findAll();
    });

    expect(result, [recentVersions[0].localDatabaseId, recentVersions[1].localDatabaseId]);
    // toSet para comparar as 2 listas que podem vir em ordens diferentes
    expect(localVersions.toSet(), recentVersions.toSet());
  });

  test("When 'clearAllVersions' is called should delete all versions", () async {
    final versions = [
      getUserVersionDto(localDatabaseId: 1),
      getUserVersionDto(localDatabaseId: 2),
    ];

    await isar.writeTxn(
      () async {
        final savedIds = await isar.userVersionDtos.putAll(versions);
        expect(savedIds.length, 2);
      },
    );

    await userVersionDataSource.clearAllVersions();

    late List<UserVersionDto> localVersions;
    await isar.txn(() async {
      localVersions = await isar.userVersionDtos.where().findAll();
    });

    expect(localVersions, []);
  });

  test("When 'getTotalSongbookVersions' is called should create stream of count versions", () async {
    final versions = [
      getUserVersionDto(songbookId: 1),
      getUserVersionDto(songbookId: 1),
    ];

    final versionsStream = userVersionDataSource.getTotalSongbookVersions(1);

    await isar.writeTxn(
      () async {
        await isar.userVersionDtos.putAll(versions);
      },
    );

    expect(versionsStream, emitsInOrder([2]));
  });

  group("When `getImagesPreview` is called", () {
    test("when found a songbook should return images of versions artists", () async {
      final artistImage = ["url1", "url2", "url4", "url4", "url6", "url4"];

      final versions = [
        getUserVersionDto(localDatabaseId: 1, artistImage: artistImage[0], songbookId: 1),
        getUserVersionDto(localDatabaseId: 2, artistImage: artistImage[1], songbookId: 1),
        getUserVersionDto(localDatabaseId: 3, artistImage: artistImage[2], songbookId: 1),
        getUserVersionDto(localDatabaseId: 4, artistImage: artistImage[3], songbookId: 1),
        getUserVersionDto(localDatabaseId: 5, artistImage: artistImage[4], songbookId: 1),
        getUserVersionDto(localDatabaseId: 6, artistImage: artistImage[5], songbookId: 1),
      ];

      await isar.writeTxn(
        () async {
          await isar.userVersionDtos.putAll(versions);
        },
      );

      final previewList = await userVersionDataSource.getImagesPreview(1);

      expect(previewList.length, 4);
    });
  });

  test("When `deleteVersions` is called should delete versions from songbook id", () async {
    final versions = [
      getUserVersionDto(songbookId: 1, localDatabaseId: 1),
      getUserVersionDto(songbookId: 1, localDatabaseId: 2),
      getUserVersionDto(songbookId: 1, localDatabaseId: 3),
      getUserVersionDto(songbookId: 2, localDatabaseId: 4),
    ];

    final versionDatas = [
      UserVersionDataDto.fromDomain(versionData: getFakeVersionData(), versionLocalDatabaseId: 1, songbookId: 1),
      UserVersionDataDto.fromDomain(versionData: getFakeVersionData(), versionLocalDatabaseId: 2, songbookId: 1),
      UserVersionDataDto.fromDomain(versionData: getFakeVersionData(), versionLocalDatabaseId: 3, songbookId: 1),
      UserVersionDataDto.fromDomain(versionData: getFakeVersionData(), versionLocalDatabaseId: 4, songbookId: 2),
    ];

    await isar.writeTxn(
      () async {
        await isar.userVersionDtos.putAll(versions);
        await isar.userVersionDataDtos.putAll(versionDatas);
      },
    );

    final numberVersionsDeleted = await userVersionDataSource.deleteVersions(1);

    expect(numberVersionsDeleted, 3);
  });

  test("When `deleteRecentVersions` is called should delete versions from songbook id", () async {
    final versions = [
      getUserRecentVersionDto(localDatabaseId: 1),
      getUserRecentVersionDto(localDatabaseId: 2),
      getUserRecentVersionDto(localDatabaseId: 3),
      getUserRecentVersionDto(localDatabaseId: 4),
    ];

    final versionDatas = [
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: 1, songbookId: ListType.recents.localId),
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: 2, songbookId: ListType.recents.localId),
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: 3, songbookId: ListType.recents.localId),
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: 4, songbookId: ListType.recents.localId),
    ];

    await isar.writeTxn(
      () async {
        await isar.userRecentVersionDtos.putAll(versions);
        await isar.userVersionDataDtos.putAll(versionDatas);
      },
    );

    final numberVersionsDeleted = await userVersionDataSource.deleteRecentVersions();

    expect(numberVersionsDeleted, 4);
  });

  test("When `deleteVersionsById` is called should delete songs from songbook", () async {
    final versions = [
      getUserVersionDto(songbookId: 1, localDatabaseId: 1),
      getUserVersionDto(songbookId: 1, localDatabaseId: 2),
      getUserVersionDto(songbookId: 1, localDatabaseId: 3),
      getUserVersionDto(songbookId: 1, localDatabaseId: 4),
    ];

    final versionDatas = [
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: versions[0].localDatabaseId, songbookId: 1),
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: versions[1].localDatabaseId, songbookId: 1),
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: versions[2].localDatabaseId, songbookId: 1),
      UserVersionDataDto.fromDomain(
          versionData: getFakeVersionData(), versionLocalDatabaseId: versions[3].localDatabaseId, songbookId: 2),
    ];

    await isar.writeTxn(
      () async {
        await isar.userVersionDtos.putAll(versions);
        await isar.userVersionDataDtos.putAll(versionDatas);
      },
    );

    final numberVersionsDeleted =
        await userVersionDataSource.deleteVersionsById(versions.map((e) => e.localDatabaseId).toList(), 1);

    expect(numberVersionsDeleted, 3);
  });

  group("when getVersionsStreamFromSongbook is called", () {
    test("when user has versions on songbook should return version list", () async {
      final fakeSongbookId = faker.randomGenerator.integer(1000);

      final versions = [
        getUserVersionDto(songbookId: fakeSongbookId),
      ];

      await isar.writeTxn(
        () async {
          await isar.userVersionDtos.putAll(versions);
        },
      );

      final result = userVersionDataSource.getVersionsStreamFromSongbook(fakeSongbookId);

      expect(result, emits(versions));
    });

    test("when user hasn't versions on songbook should return version list", () async {
      final fakeSongbookId = faker.randomGenerator.integer(1000);

      final result = userVersionDataSource.getVersionsStreamFromSongbook(fakeSongbookId);

      expect(result, emits([]));
    });
  });

  group("when getVersionsStreamFromRecentSongbook is called", () {
    test("when user has versions on songbook should return version list", () async {
      final versions = [
        getUserRecentVersionDto(),
      ];

      await isar.writeTxn(
        () async {
          await isar.userRecentVersionDtos.putAll(versions);
        },
      );

      final result = userVersionDataSource.getVersionsStreamFromRecentSongbook();

      expect(result, emits(versions));
    });

    test("when user hasn't versions on songbook should return version list", () async {
      final result = userVersionDataSource.getVersionsStreamFromRecentSongbook();

      expect(result, emits([]));
    });
  });

  test("When 'getIsFavoriteVersionBySongIdStream' is called should return bool if favorite", () async {
    final List<Completer<bool>> completers = [];
    const songId = 1;
    final version = getUserVersionDto(songId: songId, songbookId: ListType.favorites.localId);

    await isar.writeTxn(
      () async {
        await isar.userVersionDtos.put(version);
      },
    );

    completers.add(Completer());
    final stream = userVersionDataSource.getIsFavoriteVersionBySongIdStream(songId);
    stream.listen((value) => completers.last.complete(value));
    expect(await completers.last.future, isTrue);

    completers.add(Completer());
    await isar.writeTxn(
      () async {
        await isar.userVersionDtos.delete(version.localDatabaseId);
      },
    );
    expect(await completers.last.future, isFalse);
  });

  test("When 'addVersionData' is called should save version data in local DB", () async {
    final musicDto = UserVersionDataSongDto();
    musicDto.songId = 2;
    musicDto.lyricsId = 1;
    musicDto.name = "name";
    musicDto.description = "description";
    musicDto.url = "https://example.com/music.json";

    final fakeUserVersionDataDto = UserVersionDataDto(
      localDatabaseId: 12,
      versionId: 1,
      instrument: Instrument.bass,
      content: "Content",
      versionName: "Label",
      versionUrl: "https://example.com/version.mp3",
      completePath: "https://example.com/song.json",
      siteUrl: "https://example.com/site.json",
      key: "Key",
      shapeKey: "Shape Key",
      stdKey: "Std Key",
      stdShapeKey: "Std Shape Key",
      tuning: "Tuning",
      capo: 5,
      composers: "Composers",
      isVerified: true,
      blocked: false,
      reason: "Reason",
      song: musicDto,
      versionLocalDatabaseId: 11,
      songbookId: 1,
    );

    await userVersionDataSource.addVersionData(fakeUserVersionDataDto);

    final userVersionData = await isar.userVersionDataDtos.get(12);

    expect(userVersionData, fakeUserVersionDataDto);
  });
}
