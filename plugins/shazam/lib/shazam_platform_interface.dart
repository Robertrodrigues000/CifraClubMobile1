import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'shazam_method_channel.dart';

abstract class ShazamPlatform extends PlatformInterface {
  /// Constructs a ShazamPlatform.
  ShazamPlatform() : super(token: _token);

  static final Object _token = Object();

  static ShazamPlatform _instance = MethodChannelShazam();

  /// The default instance of [ShazamPlatform] to use.
  ///
  /// Defaults to [MethodChannelShazam].
  static ShazamPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ShazamPlatform] when
  /// they register themselves.
  static set instance(ShazamPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
