import 'package:cifraclub/data/clients/http/authorization_interceptor.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _GetCredentialMock extends Mock implements GetCredential {}

void main() {
  group("when `onRequest()` is invoked", () {
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(1671132940000);
    final getCredential = _GetCredentialMock();
    when(getCredential).thenReturn(const UserCredential(isUserLoggedIn: false));

    test("Fill the request with appropriate headers", () {
      final AuthorizationInterceptor authorizationInterceptor = AuthorizationInterceptor(getCredential);
      final RequestInterceptorHandler handler = RequestInterceptorHandler();
      RequestOptions requestOptions = RequestOptions(path: "/v3/genres");
      authorizationInterceptor.onRequest(requestOptions, handler, currentTime: now);
      expect(requestOptions.headers.length, 3);
      expect(requestOptions.headers["Authorization"], "StudioSol KHpfy5RiMHJn0E1Hgp1xIg");
      expect(requestOptions.headers["X-Expires"], "1671133000");
    });
    test("Fill the request with appropriate headers when request has queryParams", () {
      final AuthorizationInterceptor authorizationInterceptor = AuthorizationInterceptor(getCredential);
      final RequestInterceptorHandler handler = RequestInterceptorHandler();
      var queryParameters = {"genre": "mpb", "limit": 100};
      RequestOptions requestOptions = RequestOptions(path: "/v3/genres", queryParameters: queryParameters);
      authorizationInterceptor.onRequest(requestOptions, handler, currentTime: now);
      expect(requestOptions.headers.length, 3);
      expect(requestOptions.headers["Authorization"], "StudioSol j95CAYsiubVKpBr2WjVVBg");
      expect(requestOptions.headers["X-Expires"], "1671133000");
    });

    test("when user is log in should send jwt in header", () {
      final getCredential = _GetCredentialMock();
      final jwt = faker.jwt.secret;
      when(getCredential).thenReturn(UserCredential(isUserLoggedIn: true, jwt: jwt));

      final AuthorizationInterceptor authorizationInterceptor = AuthorizationInterceptor(getCredential);
      final RequestInterceptorHandler handler = RequestInterceptorHandler();
      RequestOptions requestOptions = RequestOptions(path: "/v3/genres");
      authorizationInterceptor.onRequest(requestOptions, handler, currentTime: now);

      verify(getCredential).called(1);
      expect(requestOptions.headers.length, 4);
      expect(requestOptions.headers["Authorization"], "StudioSol KHpfy5RiMHJn0E1Hgp1xIg");
      expect(requestOptions.headers["X-Expires"], "1671133000");
      expect(requestOptions.headers["X-Authorization"], "Bearer $jwt");
    });
  });
}
