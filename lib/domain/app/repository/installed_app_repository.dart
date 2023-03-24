import 'package:cifraclub/domain/app/model/app.dart';

abstract class InstalledAppRepository {
  Future<bool> isAppInstalled(App app);
  Future<void> openApp(App app);
}
