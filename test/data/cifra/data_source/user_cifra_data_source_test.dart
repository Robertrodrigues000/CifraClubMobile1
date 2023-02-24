import 'package:cifraclub/data/cifra/data_source/user_cifra_data_source.dart';
import 'package:cifraclub/data/songbook/models/user_cifra_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../test_helpers/isar_test_module.dart';

void main() {
  late Isar isar;

  late UserCifraDataSource userCifraDataSource;

  setUpAll(() async {
    await IsarTestModule.initializeCore();
  });

  setUp(() async {
    isar = await IsarTestModule.getIsar();
    userCifraDataSource = UserCifraDataSource(isar: isar);
  });

  group("when getCifrasFromSongbook is called", () {
    test("when user has cifras on songbook should return cifras list", () async {
      final cifras = [UserCifraDto(name: "teste1"), UserCifraDto(name: "teste2")];
      final fakeUserSongBookDto = UserSongbookDto(
        id: faker.randomGenerator.integer(1000),
        createdAt: faker.date.dateTime(),
        lastUpdated: faker.date.dateTime(),
        name: faker.animal.name(),
      );

      await isar.writeTxn(
        () async {
          await isar.userCifraDtos.put(cifras[0]);
          await isar.userCifraDtos.put(cifras[1]);
          fakeUserSongBookDto.userCifras.addAll(cifras);
          await isar.userSongbookDtos.put(fakeUserSongBookDto);
          await fakeUserSongBookDto.userCifras.save();
        },
      );

      final result = await userCifraDataSource.getCifrasFromSongbook(fakeUserSongBookDto.id);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result!.length, 2);
      expect(result.first.name, cifras.first.name);
      expect(result.last.name, cifras.last.name);
    });

    test("when user add cifra in a songbook should persist correctly", () async {
      final userCifraDto = UserCifraDto(name: faker.animal.name());

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

      await userCifraDataSource.addCifraToSongbook(fakeUserSongBookDto.id, userCifraDto);

      final result = (await isar.userSongbookDtos.get(fakeUserSongBookDto.id))?.userCifras.toList();

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result!.first.id, userCifraDto.id);
      expect(result.first.name, userCifraDto.name);
    });
  });
}
