import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:isar/isar.dart';

class UserGenreDataSource {
  Isar isar;
  UserGenreDataSource({
    required this.isar,
  });

  Stream<UserGenresDto?> getAll() {
    final userGenresDto = isar.userGenresDtos.watchObject(UserGenresDto.userGenreId, fireImmediately: true);
    return userGenresDto;
  }

  Future<void> setAll(List<UserGenreDto> userGenre) async {
    try {
      await isar.writeTxn(
        () async {
          var userGenresDto = UserGenresDto(genres: userGenre);
          isar.userGenresDtos.put(userGenresDto);
        },
      );
    } catch (error) {
      logger?.sendNonFatalCrash(exception: error);
    }
  }
}
