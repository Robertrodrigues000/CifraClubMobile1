// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  Dio getDio() {
    return Dio();
  }

  @singleton
  CifraClubAPINetworkService getCifraClubAPINetworkService(Dio dio) {
    return CifraClubAPINetworkService(dio: dio);
  }
}
