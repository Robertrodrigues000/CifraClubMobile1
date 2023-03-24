// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOperatingSystem {
  OperatingSystem call() {
    switch (Platform.operatingSystem) {
      case "android":
        return OperatingSystem.android;
      case "ios":
        return OperatingSystem.ios;
      case "macos":
        return OperatingSystem.macos;
      case "windows":
        return OperatingSystem.windows;
      case "fuchsia":
        return OperatingSystem.fuchsia;
      case "linux":
        return OperatingSystem.linux;
      default:
        return OperatingSystem.unknown;
    }
  }
}
