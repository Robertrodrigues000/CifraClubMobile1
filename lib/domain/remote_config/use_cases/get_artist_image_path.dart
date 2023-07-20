// coverage:ignore-file
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetArtistImagePathUrl {
  final RemoteConfigRepository remoteConfigRepository;

  GetArtistImagePathUrl(this.remoteConfigRepository);

  String call() {
    return remoteConfigRepository.getArtistImagePath();
  }
}
