import 'package:flutter_test/flutter_test.dart';
import 'package:local_songs/local_songs.dart';
import 'package:local_songs/local_songs_platform_interface.dart';
import 'package:local_songs/local_songs_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLocalSongsPlatform
    with MockPlatformInterfaceMixin
    implements LocalSongsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LocalSongsPlatform initialPlatform = LocalSongsPlatform.instance;

  test('$MethodChannelLocalSongs is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLocalSongs>());
  });

  test('getPlatformVersion', () async {
    LocalSongs localSongsPlugin = LocalSongs();
    MockLocalSongsPlatform fakePlatform = MockLocalSongsPlatform();
    LocalSongsPlatform.instance = fakePlatform;

    expect(await localSongsPlugin.getPlatformVersion(), '42');
  });
}
