// coverage:ignore-file
import 'package:cifraclub/data/app/repository/installed_app_repository_impl.dart';
import 'package:cifraclub/data/app/repository/share_link_repository_impl.dart';
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart';
import 'package:cifraclub/domain/app/repository/share_link_repository.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  InstalledAppRepository getInstalledAppRepository(GetOperatingSystem getOperatingSystem) {
    return InstalledAppRepositoryImpl(getOperatingSystem());
  }

  ShareLinkRepository getShareLinkRepository(GetOperatingSystem getOperatingSystem) {
    return ShareLinkRepositoryImpl();
  }
}
