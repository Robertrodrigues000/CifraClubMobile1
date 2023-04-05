import 'package:cifraclub/data/clients/http/authorization_interceptor.dart';
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _DioMock extends Mock implements Dio {
  final _interceptors = Interceptors();

  @override
  BaseOptions options = BaseOptions();

  @override
  Interceptors get interceptors => _interceptors;
}

class _GetCredentialMock extends Mock implements GetCredential {}

void main() {
  final dio = _DioMock();
  group("When CifraClubAPINetworkService is created", () {
    test("Setup dio with correct settings", () {
      var _ = CifraClubAPINetworkService(dio: dio, getCredential: _GetCredentialMock());

      expect(dio.options.baseUrl, "https://api.cifraclub.com.br");
      expect(dio.interceptors.length, 1);
      expect(dio.interceptors.first.runtimeType, AuthorizationInterceptor);
    });
  });
}
