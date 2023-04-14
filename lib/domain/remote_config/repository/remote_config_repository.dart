import 'package:cifraclub/domain/remote_config/models/instrument_urls.dart';
import 'package:cifraclub/domain/remote_config/models/remote_product.dart';

abstract class RemoteConfigRepository {
  bool get wasValuesfetched;

  Future<bool> fetch();

  InstrumentUrls getInstrumentUrls();

  List<int> getTimeBetweenInterstitials();

  List<RemoteProduct> getProducts();

  List<String> getProductsIds();
}
