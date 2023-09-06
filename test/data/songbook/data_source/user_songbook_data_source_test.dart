import 'dart:math';

import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_artist_dto.dart';
import 'package:cifraclub/data/version/models/user_version/user_version_dto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../test_helpers/isar_test_module.dart';

void main() {
  late Isar isar;

  late UserSongbookDataSource userSongbookDataSource;

  setUpAll(() async {
    await IsarTestModule.initializeCore();
  });

  setUp(() async {
    isar = await IsarTestModule.getIsar();
    userSongbookDataSource = UserSongbookDataSource(isar);
  });

  group("when getAll is called", () {
    test("when user has no songbook should return empty list", () async {
      final totalSongbooks = await userSongbookDataSource.getAll().first;
      expect(totalSongbooks, isEmpty);
    });

    test("when user has a songbook without cifras should return list of songbooks with empty cifra list", () async {
      final fakeUserSongBookDto = UserSongbookDto(
        id: faker.randomGenerator.integer(1000),
        createdAt: faker.date.dateTime(),
        lastUpdated: faker.date.dateTime(),
        name: faker.animal.name(),
        type: ListTypeDto.user,
        isPublic: false,
        totalSongs: 0,
        preview: const [],
      );

      await isar.writeTxn(
        () async {
          await isar.userSongbookDtos.put(fakeUserSongBookDto);
        },
      );

      final userSongbookDto = await userSongbookDataSource.getAll().first;

      expect(userSongbookDto, isNotNull);
      expect(userSongbookDto.first.id, fakeUserSongBookDto.id);
      expect(userSongbookDto.first.createdAt, fakeUserSongBookDto.createdAt);
      expect(userSongbookDto.first.lastUpdated, fakeUserSongBookDto.lastUpdated);
      expect(userSongbookDto.first.name, fakeUserSongBookDto.name);
    });
  });

  group("when insert is called", () {
    test("when songbook has id, should return same id", () async {
      final fakeUserSongBookDto = UserSongbookDto(
        id: faker.randomGenerator.integer(1000),
        createdAt: faker.date.dateTime(),
        lastUpdated: faker.date.dateTime(),
        name: faker.animal.name(),
        type: ListTypeDto.user,
        isPublic: false,
        totalSongs: 0,
        preview: const [],
      );

      final insertedId = await userSongbookDataSource.put(fakeUserSongBookDto);

      expect(insertedId, fakeUserSongBookDto.id);
    });

    test("when songbook has no id, should throw exception", () async {
      final fakeUserSongBookDto = UserSongbookDto(
        createdAt: faker.date.dateTime(),
        lastUpdated: faker.date.dateTime(),
        name: faker.animal.name(),
        type: ListTypeDto.user,
        isPublic: false,
        totalSongs: 0,
        preview: const [],
        id: Isar.autoIncrement,
      );

      expect(() async => userSongbookDataSource.put(fakeUserSongBookDto), throwsException);
    });
  });

  group("when setAll is called", () {
    test("should clear and insert all songbooks from list", () async {
      await isar.writeTxn(
        () async {
          await isar.userSongbookDtos.put(UserSongbookDto(
            id: 1000,
            createdAt: DateTime.now(),
            lastUpdated: DateTime.now(),
            name: "old",
            type: ListTypeDto.user,
            isPublic: false,
            totalSongs: 0,
            preview: const [],
          ));
        },
      );

      final songbooks = [
        UserSongbookDto(
          id: 2000,
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now(),
          name: "new",
          type: ListTypeDto.user,
          isPublic: false,
          totalSongs: 0,
          preview: const [],
        )
      ];

      final ids = await userSongbookDataSource.setAll(songbooks);

      expect(ids, [2000]);
      expect(isar.userSongbookDtos.countSync(), 1);
    });

    test("when a songbook has no id, should throw exception", () async {
      final songbooks = [
        UserSongbookDto(
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now(),
          name: "new",
          type: ListTypeDto.user,
          isPublic: false,
          totalSongs: 0,
          preview: const [],
          id: Isar.autoIncrement,
        )
      ];
      expect(() async => userSongbookDataSource.setAll(songbooks), throwsException);
    });
  });

  group("When deleteSongbook is called ", () {
    test("and have id in user songbook list should return true", () async {
      final songbookId = Random().nextInt(1000);

      await isar.writeTxn(
        () async {
          await isar.userSongbookDtos.put(
            UserSongbookDto(
              id: songbookId,
              createdAt: DateTime.now(),
              lastUpdated: DateTime.now(),
              name: "old",
              type: ListTypeDto.user,
              isPublic: false,
              totalSongs: 0,
              preview: const [],
            ),
          );
        },
      );

      final result = await userSongbookDataSource.deleteSongbook(songbookId);

      expect(result, isTrue);
    });

    test("and haven't id in user songbook list should return false", () async {
      final songbookId = Random().nextInt(1000);

      await isar.writeTxn(
        () async {
          await isar.userSongbookDtos.put(
            UserSongbookDto(
              id: 2000,
              createdAt: DateTime.now(),
              lastUpdated: DateTime.now(),
              name: "old",
              type: ListTypeDto.user,
              isPublic: false,
              totalSongs: 0,
              preview: const [],
            ),
          );
        },
      );

      final result = await userSongbookDataSource.deleteSongbook(songbookId);

      expect(result, isFalse);
    });
  });

  test("when insert is called, should return a songbookId", () async {
    final fakeUserSongBookDto = UserSongbookDto(
      id: faker.randomGenerator.integer(100),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 0,
      preview: const [],
    );

    final insertedId = await userSongbookDataSource.put(fakeUserSongBookDto);

    expect(insertedId, fakeUserSongBookDto.id);
  });

  test("when getSongbookById is called, should return a songbook", () async {
    final fakeUserSongBookDto = UserSongbookDto(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 0,
      preview: const [],
    );

    await isar.writeTxn(
      () async {
        await isar.userSongbookDtos.put(fakeUserSongBookDto);
      },
    );

    final songbook = await userSongbookDataSource.getSongbookById(fakeUserSongBookDto.id);
    expect(songbook, fakeUserSongBookDto);
  });

  test("when getSongbookStreamById is called, should return a songbook", () async {
    final fakeUserSongBookDto = UserSongbookDto(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 0,
      preview: const [],
    );

    await isar.writeTxn(
      () async {
        await isar.userSongbookDtos.put(fakeUserSongBookDto);
      },
    );

    final songbook = userSongbookDataSource.getSongbookStreamById(fakeUserSongBookDto.id);
    expect(songbook, emits(fakeUserSongBookDto));
  });

  test("when getSongbookStreamById is called and songbook id is null, should return null", () async {
    final songbook = userSongbookDataSource.getSongbookStreamById(null);
    expect(songbook, emits(null));
  });

  test("when getTotalSongbooks is called should return total of list of songbooks from user", () async {
    final fakeUserSongBookDto = UserSongbookDto(
      id: faker.randomGenerator.integer(1000),
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 0,
      preview: const [],
    );

    final totalSongbooksStream = userSongbookDataSource.getTotalSongbooks();

    await isar.writeTxn(
      () async {
        await isar.userSongbookDtos.put(fakeUserSongBookDto);
      },
    );

    expect(totalSongbooksStream, emitsInOrder([1]));
  });

  test("When updatePreview is called should add list of preview in songbook", () async {
    final fakeUserSongBookDto = UserSongbookDto(
      id: 1,
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 0,
      preview: const [],
    );

    await isar.writeTxn(
      () async {
        await isar.userSongbookDtos.put(fakeUserSongBookDto);
      },
    );

    final updatedSongbookId = await userSongbookDataSource.updatePreview(1, ["image1", "image2"]);

    expect(updatedSongbookId, 1);

    await isar.txn(
      () async {
        final songbook = await isar.userSongbookDtos.where().idEqualTo(1).findFirst();
        expect(songbook?.preview, ["image1", "image2"]);
      },
    );
  });

  test("When updatePreview is called and don't have songbook with same id should return null", () async {
    final updatedSongbookId = await userSongbookDataSource.updatePreview(1, ["image1", "image2"]);

    expect(updatedSongbookId, null);
  });

  test("when deleteAll is called should delete all songbooks from isar", () async {
    await isar.writeTxn(
      () async {
        await isar.userSongbookDtos.put(
          UserSongbookDto(
            id: 1,
            createdAt: DateTime.now(),
            lastUpdated: DateTime.now(),
            name: "old",
            type: ListTypeDto.user,
            isPublic: false,
            totalSongs: 0,
            preview: const [],
          ),
        );
      },
    );

    await userSongbookDataSource.deleteAll();

    expect(await isar.userSongbookDtos.getSize(), 0);
  });

  test("When updateTotalSongs is called should update totalSongs of the songbook", () async {
    final fakeUserSongbookDto = UserSongbookDto(
      id: 1,
      createdAt: faker.date.dateTime(),
      lastUpdated: faker.date.dateTime(),
      name: faker.animal.name(),
      type: ListTypeDto.user,
      isPublic: false,
      totalSongs: 2,
      preview: const [],
    );

    final version = UserVersionDto(
      localDatabaseId: 1,
      remoteDatabaseId: 1,
      songbookId: 1,
      songUrl: "songUrl",
      type: 1,
      name: "name",
      songId: 1,
      artist: UserVersionArtistDto(),
      versionId: 1,
      order: 0,
    );

    await isar.writeTxn(
      () async {
        await isar.userSongbookDtos.put(fakeUserSongbookDto);
        await isar.userVersionDtos.put(version);
      },
    );

    final updatedSongbookId = await userSongbookDataSource.updateTotalSongs(1);

    expect(updatedSongbookId, 1);

    await isar.txn(
      () async {
        final songbook = await isar.userSongbookDtos.where().idEqualTo(1).findFirst();
        expect(songbook?.totalSongs, 1);
      },
    );
  });

  tearDown(() {
    isar.close(deleteFromDisk: true);
  });
}
