// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/domain/genre/models/all_genres.dart';
import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class GenresRepositoryImpl extends GenresRepository {
  GenresDataSource genresDataSource;

  GenresRepositoryImpl({
    required this.genresDataSource,
  });

  @override
  Future<Result<AllGenres, RequestError>> getGenres() async {
    return (await genresDataSource.getGenres()).map((data) => data.toDomain());
  }
}
