// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/versions_limit_constants.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVersionsLimitConstants {
  final RemoteConfigRepository remoteConfigRepository;

  GetVersionsLimitConstants(this.remoteConfigRepository);

  VersionsLimitConstants call() {
    return remoteConfigRepository.getVersionsLimitConstants();
  }
}
