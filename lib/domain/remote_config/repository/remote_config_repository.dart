import 'package:cifraclub/domain/list_limit/models/list_limit_constants.dart';
import 'package:cifraclub/domain/list_limit/models/versions_limit_constants.dart';
import 'package:cifraclub/domain/remote_config/models/instrument_urls.dart';
import 'package:cifraclub/domain/remote_config/models/remote_product.dart';

abstract class RemoteConfigRepository {
  bool get wasValuesFetched;

  Future<bool> fetch();

  InstrumentUrls getInstrumentUrls();

  List<int> getTimeBetweenInterstitials();

  List<RemoteProduct> getProducts();

  List<String> getProductsIds();

  ListLimitConstants getListLimitConstants();

  VersionsLimitConstants getVersionsLimitConstants();
}
