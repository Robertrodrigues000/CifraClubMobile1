
import 'shazam_platform_interface.dart';

class Shazam {
  Future<String?> getPlatformVersion() {
    return ShazamPlatform.instance.getPlatformVersion();
  }
}
