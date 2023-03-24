// coverage:ignore-file
import 'package:cifraclub/data/device/url_launcher/repository/url_launcher_repository_impl.dart';
import 'package:cifraclub/domain/device/url_launcher/repository/url_launcher_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DeviceModule {
  UrlLauncherRepository getUrlLauncherRepository() {
    return UrlLauncherRepositoryImpl();
  }
}
