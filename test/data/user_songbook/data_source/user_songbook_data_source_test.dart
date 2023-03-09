import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
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
      expect(userSongbookDto.first.userCifras, isEmpty);
    });

    test("when user has songbooks with cifras should return unloaded cifra list", () async {
      final fakeUserSongBookDto = UserSongbookDto(
        id: faker.randomGenerator.integer(1000),
        createdAt: faker.date.dateTime(),
        lastUpdated: faker.date.dateTime(),
        name: faker.animal.name(),
      );

      final userCifraDto = UserCifraDto(name: faker.animal.name());

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
      );

      final insertedId = await userSongbookDataSource.insert(fakeUserSongBookDto);

      expect(insertedId, fakeUserSongBookDto.id);
    });

    test("when songbook has no id, should return a new same id", () async {
      final fakeUserSongBookDto = UserSongbookDto(
        createdAt: faker.date.dateTime(),
        lastUpdated: faker.date.dateTime(),
        name: faker.animal.name(),
      );

      final insertedId = await userSongbookDataSource.insert(fakeUserSongBookDto);

      expect(insertedId, isNot(Isar.autoIncrement));
      expect(insertedId, isNotNull);
      expect(insertedId, isNot(0));
    });
  });
}
