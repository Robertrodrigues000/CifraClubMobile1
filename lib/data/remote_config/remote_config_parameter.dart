import 'package:cifraclub/domain/log/repository/log_repository.dart';

/// This class must be extended and must be included in RemoteConfigParameters's registeredParams list
abstract class RemoteConfigParameter<T> {
  /// Parameter's key
  String get remoteConfigKey;

  /// Default raw value used when remote config fetch or parse fails
  String get defaultValue;

  String? _remoteValue;

  /// This value is nullable so it can have a lazy initialization
  T? _value;

  /// This function transforms the string received from remote config to T
  /// if an exception is thrown by this function, the default value will be set
  T parseParam(String value);

  T get value {
    _value ??= _tryParseValue(_remoteValue ?? defaultValue);
    return _value!;
  }

  void setRemoteData(String value) {
    _remoteValue = value;
    _value = null;
  }

  T _tryParseValue(String rawData) {
    try {
      return parseParam(rawData);
    } catch (e, s) {
      logger?.sendNonFatalCrash(exception: e, stack: s);
      return parseParam(defaultValue);
    }
  }
}
