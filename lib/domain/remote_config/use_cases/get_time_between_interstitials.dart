// coverage:ignore-file
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTimeBetweenInterstitials {
  final RemoteConfigRepository remoteConfigRepository;

  GetTimeBetweenInterstitials(this.remoteConfigRepository);

  List<int> call() {
    return remoteConfigRepository.getTimeBetweenInterstitials();
  }
}
