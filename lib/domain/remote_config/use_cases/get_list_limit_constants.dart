// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetListLimitConstants {
  final RemoteConfigRepository remoteConfigRepository;

  GetListLimitConstants(this.remoteConfigRepository);

  ListLimitConstants call() {
    return remoteConfigRepository.getListLimitConstants();
  }
}
