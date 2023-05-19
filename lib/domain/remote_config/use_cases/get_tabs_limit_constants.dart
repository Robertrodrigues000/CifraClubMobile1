// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/tabs_limit_constants.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTabsLimitConstants {
  final RemoteConfigRepository remoteConfigRepository;

  GetTabsLimitConstants(this.remoteConfigRepository);

  TabsLimitConstants call() {
    return remoteConfigRepository.getTabsLimitConstants();
  }
}
