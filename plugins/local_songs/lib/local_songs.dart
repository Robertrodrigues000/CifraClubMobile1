
import 'local_songs_platform_interface.dart';

class LocalSongs {
  Future<String?> getPlatformVersion() {
    return LocalSongsPlatform.instance.getPlatformVersion();
  }
}
