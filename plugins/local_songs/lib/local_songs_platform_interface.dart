import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'local_songs_method_channel.dart';

abstract class LocalSongsPlatform extends PlatformInterface {
  /// Constructs a LocalSongsPlatform.
  LocalSongsPlatform() : super(token: _token);

  static final Object _token = Object();

  static LocalSongsPlatform _instance = MethodChannelLocalSongs();

  /// The default instance of [LocalSongsPlatform] to use.
  ///
  /// Defaults to [MethodChannelLocalSongs].
  static LocalSongsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LocalSongsPlatform] when
  /// they register themselves.
  static set instance(LocalSongsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
