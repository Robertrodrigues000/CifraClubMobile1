import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'local_songs_platform_interface.dart';

/// An implementation of [LocalSongsPlatform] that uses method channels.
class MethodChannelLocalSongs extends LocalSongsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('local_songs');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
