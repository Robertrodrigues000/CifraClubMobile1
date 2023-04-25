import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_cifra_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
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
      final userSongbookDto = await userSongbookDataSource.getAll().first;
      expect(userSongbookDto, isEmpty);
    });

    test("when user has a songbook without cifras should return list of songbooks with empty cifra list", () async {
      final fakeUserSongBookDto = UserSongbookDto(
          id: faker.randomGenerator.integer(1000),
          createdAt: faker.date.dateTime(),
          lastUpdated: faker.date.dateTime(),
          name: faker.animal.name(),
          type: ListTypeDto.user,
          isPublic: false,
          totalSongs: 0);

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
      expect(userSongbookDto.first.userCifras, isEmpty);
    });

    test("when user has songbooks with cifras should return unloaded cifra list", () async {
      final fakeUserSongBookDto = UserSongbookDto(
          id: faker.randomGenerator.integer(1000),
          createdAt: faker.date.dateTime(),
          lastUpdated: faker.date.dateTime(),
          name: faker.animal.name(),
          type: ListTypeDto.user,
          isPublic: false,
          totalSongs: 1);

      final userCifraDto = UserCifraDto(name: faker.animal.name(), apiId: 1, songUrl: "testemunho", tone: "F", type: 1);

      await isar.writeTxn(
        () async {
          await isar.userSongbookDtos.put(fakeUserSongBookDto);
          await isar.userCifraDtos.put(userCifraDto);
          fakeUserSongBookDto.userCifras.add(userCifraDto);
          await fakeUserSongBookDto.userCifras.save();
        },
      );

      final result = await userSongbookDataSource.getAll().first;

      expect(result, isNotNull);
      expect(result.first.id, fakeUserSongBookDto.id);
      expect(result.first.createdAt, fakeUserSongBookDto.createdAt);
      expect(result.first.lastUpdated, fakeUserSongBookDto.lastUpdated);
      expect(result.first.name, fakeUserSongBookDto.name);
      expect(result.first.userCifras.isLoaded, false);
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
          totalSongs: 0);

      final insertedId = await userSongbookDataSource.insert(fakeUserSongBookDto);

      expect(insertedId, fakeUserSongBookDto.id);
    });

    test("when songbook has no id, should throw exception", () async {
      final fakeUserSongBookDto = UserSongbookDto(
          createdAt: faker.date.dateTime(),
          lastUpdated: faker.date.dateTime(),
          name: faker.animal.name(),
          type: ListTypeDto.user,
          isPublic: false,
          totalSongs: 0);

      expect(() async => userSongbookDataSource.insert(fakeUserSongBookDto), throwsException);
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
        )
      ];
      expect(() async => userSongbookDataSource.setAll(songbooks), throwsException);
    });
  });
}
