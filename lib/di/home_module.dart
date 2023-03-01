// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/home/data_souce/home_data_source.dart';
import 'package:cifraclub/data/home/repository/home_repository_impl.dart';
import 'package:cifraclub/domain/home/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HomeModule {
  HomeDataSource getHomeDataSource(CifraClubAPINetworkService networkService) {
    return HomeDataSource(networkService);
  }

  HomeRepository getHomeRepository(HomeDataSource homeDataSource) {
    return HomeRepositoryImpl(homeDataSource);
  }
}
