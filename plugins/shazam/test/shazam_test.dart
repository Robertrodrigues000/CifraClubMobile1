import 'package:flutter_test/flutter_test.dart';
import 'package:shazam/shazam.dart';
import 'package:shazam/shazam_platform_interface.dart';
import 'package:shazam/shazam_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockShazamPlatform
    with MockPlatformInterfaceMixin
    implements ShazamPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ShazamPlatform initialPlatform = ShazamPlatform.instance;

  test('$MethodChannelShazam is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelShazam>());
  });

  test('getPlatformVersion', () async {
    Shazam shazamPlugin = Shazam();
    MockShazamPlatform fakePlatform = MockShazamPlatform();
    ShazamPlatform.instance = fakePlatform;

    expect(await shazamPlugin.getPlatformVersion(), '42');
  });
}
