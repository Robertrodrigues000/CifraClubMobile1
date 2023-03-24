import 'package:cifraclub/domain/app/model/app.dart';
import 'package:cifraclub/domain/app/use_cases/is_app_installed.dart';
import 'package:cifraclub/domain/app/use_cases/open_app.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart';
import 'package:injectable/injectable.dart';

@injectable
class OpenAppOrStore {
  final OpenApp openApp;
  final OpenUrl openUrl;
  final IsAppInstalled isAppInstalled;
  final GetOperatingSystem getOperatingSystem;

  OpenAppOrStore({
    required this.openApp,
    required this.openUrl,
    required this.isAppInstalled,
    required this.getOperatingSystem,
  });

  Future<void> call(App app) async {
    final os = getOperatingSystem();
    if (await isAppInstalled(app)) {
      openApp(app);
    } else {
      switch (os) {
        case OperatingSystem.android:
          openUrl(app.googlePlayUrl);
          break;
        case OperatingSystem.ios:
          openUrl(app.appStoreUrl);
          break;
        default:
          break;
      }
    }
  }
}
