// coverage:ignore-file
import 'package:cifraclub/domain/app/models/app.dart';
import 'package:cifraclub/domain/app/repository/installed_app_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class OpenApp {
  final InstalledAppRepository installedAppRepository;

  const OpenApp({required this.installedAppRepository});

  Future<void> call(App app) {
    return installedAppRepository.openApp(app);
  }
}
