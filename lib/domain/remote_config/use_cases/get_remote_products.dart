// coverage:ignore-file
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRemoteProductsIds {
  final RemoteConfigRepository remoteConfigRepository;

  GetRemoteProductsIds(this.remoteConfigRepository);

  List<String> call() {
    return remoteConfigRepository.getProductsIds();
  }
}
