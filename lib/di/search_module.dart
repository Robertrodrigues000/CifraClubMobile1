// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/data/search/repository/search_repository_impl.dart';
import 'package:cifraclub/data/search/repository/shazam_repository_impl.dart';
import 'package:cifraclub/domain/search/repository/search_repository.dart';
import 'package:cifraclub/domain/search/repository/shazam_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shazam/pigeon.g.dart';

@module
abstract class SearchModule {
  SearchDataSource getSearchDataSource(CifraClubAPINetworkService networkService) {
    return SearchDataSource(
      networkService: networkService,
    );
  }

  SearchRepository getSearchRepository(SearchDataSource searchDataSource) {
    return SearchRepositoryImpl(
      searchDataSource: searchDataSource,
    );
  }

  ShazamRepository getShazamRepository() {
    return ShazamRepositoryImpl(ShazamHostApi());
  }
}
