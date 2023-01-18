// coverage:ignore-file
import 'package:cifraclub/domain/remote_config/models/instrument_urls.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInstrumentUrls {
  final RemoteConfigRepository remoteConfigRepository;

  GetInstrumentUrls(this.remoteConfigRepository);

  InstrumentUrls call() {
    return remoteConfigRepository.getInstrumentUrls();
  }
}
