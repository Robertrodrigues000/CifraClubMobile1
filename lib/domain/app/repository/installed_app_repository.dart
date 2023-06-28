import 'package:cifraclub/domain/app/models/app.dart';

abstract class InstalledAppRepository {
  Future<bool> isAppInstalled(App app);
  Future<void> openApp(App app);
}
