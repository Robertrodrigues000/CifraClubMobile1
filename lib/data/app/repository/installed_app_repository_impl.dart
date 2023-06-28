// coverage:ignore-file
// AppCheck uses Platform.isAndroid and Platform.isIOS,
// which we can't override in unit tests

import 'package:appcheck/appcheck.dart';
import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';

class InstalledAppRepositoryImpl extends InstalledAppRepository {
  final OperatingSystem os;

  InstalledAppRepositoryImpl(this.os);

  @override
  Future<bool> isAppInstalled(App app) async {
    try {
      if (os == OperatingSystem.ios) {
        return await AppCheck.checkAvailability(app.iosPackageName) != null;
      } else if (os == OperatingSystem.android) {
        return await AppCheck.checkAvailability(app.androidPackageName) != null;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> openApp(App app) async {
    try {
      if (os == OperatingSystem.ios) {
        return await AppCheck.launchApp(app.iosPackageName);
      } else if (os == OperatingSystem.android) {
        return await AppCheck.launchApp(app.androidPackageName);
      }
    } catch (e) {
      return;
    }
  }
}
