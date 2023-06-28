import 'package:cifraclub/data/remote_config/parameters/instrument_urls_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/list_limit_constants_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/remote_product_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/versions_limit_constants_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/time_between_interstitials_parameter.dart';
import 'package:cifraclub/data/remote_config/remote_config_parameter.dart';

class RemoteConfigRegisteredParameters {
  /// All remote config params must be registered in this list.
  late final List<RemoteConfigParameter> registeredParams = [
    instrumentUrls,
    timeBetweenInterstitials,
    products,
    listLimitConstants,
    tabsLimitConstants
  ];

  final InstrumentUrlsParameter instrumentUrls = InstrumentUrlsParameter();
  final TimeBetweenIntersitialsParameter timeBetweenInterstitials = TimeBetweenIntersitialsParameter();
  final RemoteProductParameter products = RemoteProductParameter();
  final ListLimitConstantsParameter listLimitConstants = ListLimitConstantsParameter();
  final VersionsLimitConstantsParameter tabsLimitConstants = VersionsLimitConstantsParameter();
}
