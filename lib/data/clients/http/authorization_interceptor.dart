import 'dart:convert';

import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class AuthorizationInterceptor extends Interceptor {
  static const Duration _expireLenght = Duration(seconds: 60);
  static const String _secret = "iYBc7c?TBgYhFNx97ywrit97y3hF*h{i.@AuQuCP?xoY+bFVJk";
  final GetCredential getCredential;

  AuthorizationInterceptor(this.getCredential);

  String _getAuthorizationHeader({required String path, required int expireTime}) {
    var message = _secret + path + expireTime.toString();
    var base64String = base64Encode(md5.convert(utf8.encode(message)).bytes)
        .replaceAll("+", "-")
        .replaceAll("/", "_")
        .replaceAll("=", "");
    return "StudioSol $base64String";
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler, {DateTime? currentTime}) {
    String path = options.uri.path;
    if (options.uri.hasQuery) {
      path += "?${options.uri.query}";
    }

    int expireTime =
        (currentTime ?? DateTime.now()).add(_expireLenght).millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    String authorization = _getAuthorizationHeader(path: path, expireTime: expireTime);
    options.headers["Authorization"] = authorization;
    options.headers["X-Expires"] = expireTime.toString();
    final jwt = getCredential()?.jwt;
    if (jwt != null) {
      options.headers["X-Authorization"] = "Bearer $jwt";
    }
    return super.onRequest(options, handler);
  }
}
