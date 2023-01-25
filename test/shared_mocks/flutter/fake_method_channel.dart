import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MethodChannelInvocation {
  final String method;
  final dynamic arguments;

  const MethodChannelInvocation(this.method, this.arguments);
}

class FakeMethodChannel extends Fake implements MethodChannel {
  List<MethodChannelInvocation> calls = [];
  Map<String, dynamic> answers;

  Future<dynamic> Function(MethodCall call)? handler;

  FakeMethodChannel({this.answers = const {}});

  @override
  Future<T?> invokeMethod<T>(String method, [dynamic arguments]) {
    calls.add(MethodChannelInvocation(method, arguments));
    return SynchronousFuture(answers[method]);
  }

  @override
  void setMethodCallHandler(Future<dynamic> Function(MethodCall call)? handler) {
    this.handler = handler;
  }
}
