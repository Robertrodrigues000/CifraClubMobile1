// ignore_for_file: avoid_dynamic_calls
import 'package:cifraclub/data/device/url_launcher/repository/url_launcher_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typed_result/typed_result.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MethodChannel channel = const MethodChannel('plugins.flutter.io/url_launcher');
  final List<MethodCall> logs = <MethodCall>[];

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) {
      bool shouldPass = call.arguments?['url'] != "fail";
      logs.add(call);
      return SynchronousFuture(shouldPass);
    });
  });

  tearDown(logs.clear);

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  group("When handleUrl is called", () {
    test("Successfully opening an url should return success", () async {
      UrlLauncherRepositoryImpl repository = UrlLauncherRepositoryImpl();
      const url = "https://cifraclub.com.br/";
      final result = await repository.handleUrl(url);
      expect(logs, hasLength(1));
      expect(logs.first.arguments['url'], url);
      expect(result, isA<Ok>());
    });

    test("Failing to open an url should return error", () async {
      UrlLauncherRepositoryImpl repository = UrlLauncherRepositoryImpl();
      const url = "fail";
      final result = await repository.handleUrl(url);
      expect(logs, hasLength(1));
      expect(logs.first.arguments['url'], url);
      expect(result, isA<Err>());
    });
  });
}
