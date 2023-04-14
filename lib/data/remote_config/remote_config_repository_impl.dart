import 'package:cifraclub/data/remote_config/remote_config_registered_parameters.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/remote_config/models/instrument_urls.dart';
import 'package:cifraclub/domain/remote_config/models/remote_product.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final FirebaseRemoteConfig remoteConfig;
  final RemoteConfigRegisteredParameters remoteConfigParameters;

  bool _initialized = false;
  bool _valuesReceived = false;

  @override
  bool get wasValuesfetched => _valuesReceived;

  final Map<Type, Object> parametersMap = {};

  RemoteConfigRepositoryImpl({
    required this.remoteConfig,
    required this.remoteConfigParameters,
  });

  Map<String, dynamic> getDefaultValues() {
    final defaultValues = <String, dynamic>{};
    for (final entry in remoteConfigParameters.registeredParams) {
      defaultValues[entry.remoteConfigKey] = entry.defaultValue;
    }

    return defaultValues;
  }

  Future<void> _initialize() async {
    if (_initialized) {
      return;
    }
    await remoteConfig.ensureInitialized();
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 12),
      ),
    );
    remoteConfig.addListener(_setRemoteValues);
    await remoteConfig.setDefaults(getDefaultValues());
    _initialized = true;
  }

  void _setRemoteValues() {
    for (final param in remoteConfigParameters.registeredParams) {
      final receivedValue = remoteConfig.getValue(param.remoteConfigKey);
      if (receivedValue.source == ValueSource.valueRemote) {
        try {
          param.setRemoteData(receivedValue.asString());
          _valuesReceived = true;
        } catch (e, s) {
          logger?.sendNonFatalCrash(exception: e, stack: s); // coverage:ignore-line
        }
      }
    }
  }

  @override
  Future<bool> fetch() async {
    try {
      await _initialize();
      await remoteConfig.fetchAndActivate();
    } catch (e, s) {
      // coverage:ignore-start
      if (e.runtimeType != FormatException) {
        logger?.sendNonFatalCrash(exception: e, stack: s);
      }
      // coverage:ignore-end
      return false;
    }
    return _valuesReceived;
  }

  @override
  InstrumentUrls getInstrumentUrls() {
    return remoteConfigParameters.instrumentUrls.value;
  }

  @override
  List<int> getTimeBetweenInterstitials() {
    return remoteConfigParameters.timeBetweenInterstitials.value;
  }

  @override
  List<RemoteProduct> getProducts() {
    return remoteConfigParameters.products.value;
  }

  @override
  List<String> getProductsIds() {
    return getProducts().map((remoteProduct) => remoteProduct.id).toList();
  }
}
