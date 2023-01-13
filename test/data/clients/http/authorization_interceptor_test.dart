import 'package:cifraclub/data/clients/http/authorization_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when `onRequest()` is invoked", () {
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(1671132940000);

    test("Fill the request with appropriate headers", () {
      final AuthorizationInterceptor authorizationInterceptor = AuthorizationInterceptor();
      final RequestInterceptorHandler handler = RequestInterceptorHandler();
      RequestOptions requestOptions = RequestOptions(path: "/v3/genres");
      authorizationInterceptor.onRequest(requestOptions, handler, currentTime: now);
      expect(requestOptions.headers.length, 3);
      expect(requestOptions.headers["Authorization"], "StudioSol KHpfy5RiMHJn0E1Hgp1xIg");
      expect(requestOptions.headers["X-Expires"], "1671133000");
    });
    test("Fill the request with appropriate headers when request has queryParams", () {
      final AuthorizationInterceptor authorizationInterceptor = AuthorizationInterceptor();
      final RequestInterceptorHandler handler = RequestInterceptorHandler();
      var queryParameters = {"genre": "mpb", "limit": 100};
      RequestOptions requestOptions = RequestOptions(path: "/v3/genres", queryParameters: queryParameters);
      authorizationInterceptor.onRequest(requestOptions, handler, currentTime: now);
      expect(requestOptions.headers.length, 3);
      expect(requestOptions.headers["Authorization"], "StudioSol j95CAYsiubVKpBr2WjVVBg");
      expect(requestOptions.headers["X-Expires"], "1671133000");
    });
  });
}
