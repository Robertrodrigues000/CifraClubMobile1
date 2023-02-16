// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart';
import 'package:cifraclub/data/genre/models/user_genre/user_genre_dto.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class GenresRepositoryImpl extends GenresRepository {
  GenresDataSource genresDataSource;
  UserGenreDataSource userGenreDataSource;
  GenresRepositoryImpl({
    required this.genresDataSource,
    required this.userGenreDataSource,
  });

  @override
  Future<Result<AllGenres, RequestError>> getGenres() async {
    return (await genresDataSource.getGenres()).map((data) => data.toDomain());
  }

  @override
  Future<void> setUserGenres(List<Genre> genres) async {
    return userGenreDataSource.setAll(genres.map(UserGenreDto.fromDomain).toList());
  }

  @override
  Stream<List<Genre>?> getUserGenresAsStream() {
    return userGenreDataSource.getAll().map(
          (userGenresDto) => userGenresDto?.toDomain(),
        );
  }
}
