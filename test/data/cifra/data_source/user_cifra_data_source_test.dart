import 'package:cifraclub/data/cifra/data_source/user_cifra_data_source.dart';
import 'package:cifraclub/data/cifra/models/user_cifra_artist_dto.dart';
import 'package:cifraclub/data/cifra/models/user_cifra_dto.dart';
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
    userCifraDataSource = UserCifraDataSource(isar);
  });

  tearDown(() {
    isar.close(deleteFromDisk: true);
  });

  UserCifraDto getUserCifraDto({UserCifraArtistDto? userCifraArtistDto, int? songbookId, String? artistImage}) =>
      UserCifraDto(
        name: faker.food.cuisine(),
        remoteDatabaseID: faker.randomGenerator.integer(10000),
        songUrl: faker.animal.name(),
        tone: faker.animal.name(),
        type: faker.randomGenerator.integer(10000),
        localDatabaseID: faker.randomGenerator.integer(10000),
        songId: faker.randomGenerator.integer(10000),
        songbookId: songbookId ?? faker.randomGenerator.integer(10000),
        artist: userCifraArtistDto ?? UserCifraArtistDto(),
        artistImage: artistImage,
        versionId: faker.randomGenerator.integer(10000),
      );

  group("when getCifrasFromSongbook is called", () {
    test("when user has cifras on songbook should return cifras list", () async {
      final fakeSongbookId = faker.randomGenerator.integer(1000);

      final cifras = [
        getUserCifraDto(songbookId: fakeSongbookId),
      ];

      await isar.writeTxn(
        () async {
          await isar.userCifraDtos.putAll(cifras);
        },
      );

      final result = await userCifraDataSource.getCifrasFromSongbook(fakeSongbookId);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result.length, 1);
      expect(result.first.name, cifras.first.name);
    });

    test("when user hasn't cifras on songbook should return cifras list", () async {
      final fakeSongbookId = faker.randomGenerator.integer(1000);

      final result = await userCifraDataSource.getCifrasFromSongbook(fakeSongbookId);

      expect(result, []);
    });
  });

  test("When 'addCifrasToSongbook' is called should save cifras to local db", () async {
    final cifras = [
      getUserCifraDto(),
      getUserCifraDto(),
    ];

    final result = await userCifraDataSource.addCifrasToSongbook(cifras);

    late List<UserCifraDto> localCifras;
    await isar.txn(() async {
      localCifras = await isar.userCifraDtos.where().findAll();
    });

    expect(result, [cifras[0].localDatabaseID, cifras[1].localDatabaseID]);
    // toSet para coomparar as 2 listas que podem vir em ordens diferentes
    expect(localCifras.toSet(), cifras.toSet());
  });

  test("When 'clearAllCifras' is called should delete all cifras", () async {
    final cifras = [
      getUserCifraDto(),
      getUserCifraDto(),
    ];

    await isar.writeTxn(
      () async {
        final savedIds = await isar.userCifraDtos.putAll(cifras);
        expect(savedIds.length, 2);
      },
    );

    await userCifraDataSource.clearAllCifras();

    late List<UserCifraDto> localCifras;
    await isar.txn(() async {
      localCifras = await isar.userCifraDtos.where().findAll();
    });

    expect(localCifras, []);
  });

  test("When 'getTotalSongbookCifras' is called should create stream of count cifras", () async {
    final cifras = [
      getUserCifraDto(songbookId: 1),
      getUserCifraDto(songbookId: 1),
    ];

    final cifrasStream = userCifraDataSource.getTotalSongbookCifras(1);

    await isar.writeTxn(
      () async {
        await isar.userCifraDtos.putAll(cifras);
      },
    );

    expect(cifrasStream, emitsInOrder([2]));
  });

  group("When `getImagesPreview` is called", () {
    test("when found a songbook should return images of cifras artists", () async {
      final artistImage = ["url1", "url2", "url4", "url4", "url6", "url4"];

      final cifras = [
        getUserCifraDto(artistImage: artistImage[0], songbookId: 1),
        getUserCifraDto(artistImage: artistImage[1], songbookId: 1),
        getUserCifraDto(artistImage: artistImage[2], songbookId: 1),
        getUserCifraDto(artistImage: artistImage[3], songbookId: 1),
        getUserCifraDto(artistImage: artistImage[4], songbookId: 1),
        getUserCifraDto(artistImage: artistImage[5], songbookId: 1),
      ];

      await isar.writeTxn(
        () async {
          await isar.userCifraDtos.putAll(cifras);
        },
      );

      final previewList = await userCifraDataSource.getImagesPreview(1);

      expect(previewList.length, 4);
    });
  });

  test("When `deleteCifras` is called should delete cifras from songbook id", () async {
    final cifras = [
      getUserCifraDto(songbookId: 1),
      getUserCifraDto(songbookId: 1),
      getUserCifraDto(songbookId: 1),
      getUserCifraDto(songbookId: 2),
    ];

    await isar.writeTxn(
      () async {
        await isar.userCifraDtos.putAll(cifras);
      },
    );

    final numberCifrasDeleted = await userCifraDataSource.deleteCifras(1);

    expect(numberCifrasDeleted, 3);
  });
}
