// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/data/genre/data_source/user_genre_data_source.dart';
import 'package:cifraclub/data/genre/repository/genres_repository_impl.dart';
import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@module
abstract class GenreModule {
  UserGenreDataSource getUserGenreDataSource(Isar isar) {
    return UserGenreDataSource(isar: isar);
  }

  GenresDataSource getGenresDataSource(CifraClubAPINetworkService networkService) {
    return GenresDataSource(
      networkService: networkService,
    );
  }

  GenresRepository getGenresRepository(GenresDataSource genresDataSource, UserGenreDataSource userGenreDataSource) {
    return GenresRepositoryImpl(
      genresDataSource: genresDataSource,
      userGenreDataSource: userGenreDataSource,
    );
  }
}
