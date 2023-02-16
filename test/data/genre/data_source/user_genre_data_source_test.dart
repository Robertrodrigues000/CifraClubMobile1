import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../test_helpers/isar_test_module.dart';

void main() {
  late Isar isar;

  late UserGenreDataSource userGenreDataSource;

  setUpAll(() async {
    await IsarTestModule.initializeCore();
  });

  setUp(() async {
    isar = await IsarTestModule.getIsar();
    userGenreDataSource = UserGenreDataSource(isar: isar);
  });

  group("when getAll is called", () {
    test("when user has no genres should return null", () async {
      final userGenresDto = await userGenreDataSource.getAll().first;
      expect(userGenresDto, null);
    });

    test("when user has genres should return UserGenresDto", () async {
      var genres = [UserGenreDto.fromDomain(getFakeGenre()), UserGenreDto.fromDomain(getFakeGenre())];

      await isar.writeTxn(() async {
        var userGenresDto = UserGenresDto(genres: genres);
        isar.userGenresDtos.put(userGenresDto);
      });

      final userGenresDto = await userGenreDataSource.getAll().first;
      expect(userGenresDto, isNotNull);
      expect(userGenresDto!.genres.first.name, genres.first.name);
      expect(userGenresDto.genres.first.url, genres.first.url);
      expect(userGenresDto.genres.last.name, genres.last.name);
      expect(userGenresDto.genres.last.url, genres.last.url);
    });
  });

  group("when setAll is called", () {
    test("when transaction should be able to get the user genres set", () async {
      var userGenres = [UserGenreDto.fromDomain(getFakeGenre()), UserGenreDto.fromDomain(getFakeGenre())];
      await userGenreDataSource.setAll(userGenres);
      final userGenresDto = await isar.userGenresDtos.get(UserGenresDto.userGenreId);

      expect(userGenresDto, isNotNull);
      expect(userGenresDto?.genres.first.name, userGenres.first.name);
      expect(userGenresDto?.genres.first.url, userGenres.first.url);
      expect(userGenresDto?.genres.last.name, userGenres.last.name);
      expect(userGenresDto?.genres.last.url, userGenres.last.url);
    });
  });

  tearDown(() {
    isar.close(deleteFromDisk: true);
  });
}
