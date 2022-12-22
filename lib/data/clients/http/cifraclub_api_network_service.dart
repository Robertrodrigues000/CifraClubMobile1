import 'package:cifraclub/data/clients/http/authorization_interceptor.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:dio/dio.dart';

class CifraClubAPINetworkService extends NetworkService {
  CifraClubAPINetworkService({required Dio dio})
      : super(
          dioClient: dio
            ..options.baseUrl = "https://api.cifraclub.com.br"
            ..interceptors.add(AuthorizationInterceptor()),
        );
}
