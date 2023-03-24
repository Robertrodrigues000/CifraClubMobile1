// coverage:ignore-file
//// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/app/model/app.dart';
import 'package:injectable/injectable.dart';

import 'package:cifraclub/domain/app/repository/installed_app_repository.dart';

@injectable
class IsAppInstalled {
  final InstalledAppRepository installedAppRepository;

  IsAppInstalled({
    required this.installedAppRepository,
  });

  Future<bool> call(App app) {
    return installedAppRepository.isAppInstalled(app);
  }
}
