// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  Dio getDio() {
    return Dio();
  }

  @singleton
  CifraClubAPINetworkService getCifraClubAPINetworkService(Dio dio, GetCredential getCredential) {
    return CifraClubAPINetworkService(dio: dio, getCredential: getCredential);
  }

  NetworkService getNetworkService(Dio dio, GetCredential getCredential) {
    return getCifraClubAPINetworkService(dio, getCredential);
  }
}
