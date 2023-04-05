import 'package:cifraclub/data/clients/http/authorization_interceptor.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:dio/dio.dart';

class CifraClubAPINetworkService extends NetworkService {
  CifraClubAPINetworkService({required Dio dio, required GetCredential getCredential})
      : super(
          dioClient: dio
            ..options.baseUrl = "https://api.cifraclub.com.br"
            ..interceptors.add(AuthorizationInterceptor(getCredential)),
        );
}
