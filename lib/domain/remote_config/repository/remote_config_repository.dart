import 'package:cifraclub/domain/remote_config/models/instrument_urls.dart';

abstract class RemoteConfigRepository {
  bool get wasValuesfetched;

  Future<bool> fetch();

  InstrumentUrls getInstrumentUrls();

  List<int> getTimeBetweenInterstitials();
}