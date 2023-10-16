// coverage:ignore-file
import 'package:cifraclub/data/app/repository/installed_app_repository_impl.dart';
import 'package:cifraclub/data/app/repository/share_link_repository_impl.dart';
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart';
import 'package:cifraclub/domain/app/repository/share_link_repository.dart';
import 'package:cifraclub/domain/app/use_cases/deep_link_handler.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';
import 'package:injectable/injectable.dart';
import 'package:uni_links/uni_links.dart' as uni_links;

@module
abstract class AppModule {
  InstalledAppRepository getInstalledAppRepository(GetOperatingSystem getOperatingSystem) {
    return InstalledAppRepositoryImpl(getOperatingSystem());
  }

  ShareLinkRepository getShareLinkRepository(GetOperatingSystem getOperatingSystem) {
    return ShareLinkRepositoryImpl();
  }

  DeepLinkHandler getHandleOrGetDeepLink(
    SetScreenFromUrl setScreenFromUrl,
  ) {
    return DeepLinkHandler(
      getInitialDeepLink: uni_links.getInitialLink,
      deepLinkStream: uni_links.linkStream,
      setScreenFromUrl: setScreenFromUrl,
    );
  }
}
