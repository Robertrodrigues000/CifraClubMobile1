import 'package:cifraclub/data/remote_config/remote_config_registered_parameters.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';

class _RemoteConfigValueMock extends Mock implements RemoteConfigValue {}

class FirebaseRemoteConfigMock extends Mock implements FirebaseRemoteConfig {
  static FirebaseRemoteConfigMock getDummy({
    Map<String, dynamic>? remoteValues,
    bool fetchAndActivateShouldFail = false,
  }) {
    registerFallbackValue(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1), minimumFetchInterval: const Duration(seconds: 1)));
    final remoteConfig = FirebaseRemoteConfigMock();

    final List<VoidCallback> listeners = [];
    when(remoteConfig.ensureInitialized).thenAnswer((_) => SynchronousFuture(null));
    when(() => remoteConfig.setConfigSettings(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => remoteConfig.setDefaults(any())).thenAnswer((_) => SynchronousFuture(null));
    when(() => remoteConfig.addListener(any())).thenAnswer((realInvocation) {
      listeners.add(realInvocation.positionalArguments[0]);
    });

    if (fetchAndActivateShouldFail) {
      when(remoteConfig.fetchAndActivate).thenThrow(Exception('failed'));
    } else {
      when(remoteConfig.fetchAndActivate).thenAnswer((_) {
        for (var element in listeners) {
          element.call();
        }
        return SynchronousFuture(true);
      });
    }

    Map<String, dynamic> values;
    if (remoteValues != null) {
      values = remoteValues;
    } else {
      values = {};
      for (final param in RemoteConfigRegisteredParameters().registeredParams) {
        values[param.remoteConfigKey] = param.defaultValue;
      }
    }

    when(() => remoteConfig.getString(any())).thenAnswer((realInvocation) {
      final key = realInvocation.positionalArguments.first;
      return values[key];
    });

    when(() => remoteConfig.getValue(any())).thenAnswer((realInvocation) {
      final mock = _RemoteConfigValueMock();
      when(mock.asString).thenReturn(values[realInvocation.positionalArguments.first]);
      when(() => mock.source).thenReturn(ValueSource.valueRemote);
      return mock;
    });

    return remoteConfig;
  }
}
