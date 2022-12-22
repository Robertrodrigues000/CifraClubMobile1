import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class AuthorizationInterceptor extends Interceptor {
  static const Duration _expireLenght = Duration(seconds: 60);
  static const String _secret = "iYBc7c?TBgYhFNx97ywrit97y3hF*h{i.@AuQuCP?xoY+bFVJk";

  String _getAuthorizationHeader({required String path, required int expireTime}) {
    var message = _secret + path + expireTime.toString();
    var base64String = base64Encode(md5.convert(utf8.encode(message)).bytes).replaceAll("+", "-").replaceAll("/", "_").replaceAll("=", "");
    return "StudioSol $base64String";
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler, {DateTime? currentTime}) {
    String path = options.path;
    int expireTime = (currentTime ?? DateTime.now()).add(_expireLenght).millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
    String authorization = _getAuthorizationHeader(path: path, expireTime: expireTime);
    options.headers["Authorization"] = authorization;
    options.headers["X-Expires"] = expireTime.toString();
    return super.onRequest(options, handler);
  }
}
