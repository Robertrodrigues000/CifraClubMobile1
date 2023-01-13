// coverage:ignore-file
import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/data/artist/repository/artist_repository_impl.dart';
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/domain/artist/repository/artist_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ArtistModule {
  ArtistDataSource getGenresDataSource(CifraClubAPINetworkService networkService) {
    return ArtistDataSource(
      networkService: networkService,
    );
  }

  ArtistRepository getGenresRepository(ArtistDataSource artistDataSource) {
    return ArtistRepositoryImpl(
      artistDataSource: artistDataSource,
    );
  }
}
