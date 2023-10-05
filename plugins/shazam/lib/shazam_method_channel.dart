import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'shazam_platform_interface.dart';

/// An implementation of [ShazamPlatform] that uses method channels.
class MethodChannelShazam extends ShazamPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('shazam');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
