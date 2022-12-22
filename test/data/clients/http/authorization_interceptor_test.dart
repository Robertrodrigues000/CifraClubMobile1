import 'package:cifraclub/data/clients/http/authorization_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("when `onRequest()` is invoked", () {
    final AuthorizationInterceptor authorizationInterceptor = AuthorizationInterceptor();
    final RequestInterceptorHandler handler = RequestInterceptorHandler();
    final DateTime now = DateTime.fromMillisecondsSinceEpoch(1671132940000);

    test("Fill the request with appropriate headers", () {
      RequestOptions requestOptions = RequestOptions(path: "/v3/genres");
      authorizationInterceptor.onRequest(requestOptions, handler, currentTime: now);
      expect(requestOptions.headers.length, 3);
      expect(requestOptions.headers["Authorization"], "StudioSol KHpfy5RiMHJn0E1Hgp1xIg");
      expect(requestOptions.headers["X-Expires"], "1671133000");
    });
  });
}
