import 'package:cifraclub/data/remote_config/parameters/instrument_urls_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/time_between_interstitials_parameter.dart';
import 'package:cifraclub/data/remote_config/remote_config_registered_parameters.dart';
import 'package:cifraclub/data/remote_config/remote_config_repository_impl.dart';
import 'package:cifraclub/domain/remote_config/repository/remote_config_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../shared_mocks/data/remote_config/firebase_remote_config_mock.dart';
import '../../shared_mocks/data/remote_config/int_test_param.dart';

class _RemoteConfigRegisteredParametersMock extends Mock implements RemoteConfigRegisteredParameters {}

void main() {
  late RemoteConfigRegisteredParameters mockRemoteConfigParameters;
  late FirebaseRemoteConfig mockFirebaseRemoteConfig;

  late RemoteConfigRepository repository;

  final remoteParams = [IntTestParam()];
  final testRemoteConfigParams = {remoteParams[0].remoteConfigKey: "7"};

  setUp(() {
    mockFirebaseRemoteConfig = FirebaseRemoteConfigMock.getDummy(
      remoteValues: testRemoteConfigParams,
    );

    mockRemoteConfigParameters = _RemoteConfigRegisteredParametersMock();

    when(() => mockRemoteConfigParameters.registeredParams).thenReturn(remoteParams);

    repository = RemoteConfigRepositoryImpl(
      remoteConfig: mockFirebaseRemoteConfig,
      remoteConfigParameters: mockRemoteConfigParameters,
    );
  });

  test("When created, wasValuesFetched must be false", () {
    expect(repository.wasValuesfetched, isFalse);
  });

  group("When fetching", () {
    test("initialize in the first fetch", () async {
      await repository.fetch();
      verify(mockFirebaseRemoteConfig.ensureInitialized).called(1);
    });

    test("do not initialize twice", () async {
      await repository.fetch();
      await repository.fetch();
      await repository.fetch();
      verify(mockFirebaseRemoteConfig.ensureInitialized).called(1);
    });

    test("set wasValuesFetched to true", () async {
      await repository.fetch();
      expect(repository.wasValuesfetched, isTrue);
    });

    test("call plugin's fetchAndActivate()", () async {
      await repository.fetch();
      verify(mockFirebaseRemoteConfig.fetchAndActivate).called(1);
    });

    test("fetched values are passed to parameters", () async {
      await repository.fetch();
      for (final paramTest in remoteParams) {
        expect(paramTest.value, paramTest.parseParam(testRemoteConfigParams[paramTest.remoteConfigKey]!));
      }
    });
  });

  group("check for correct value returned when", () {
    test(" getInstrumentUrls() called", () async {
      final instrumentUrlsParameter = InstrumentUrlsParameter();
      when(() => mockRemoteConfigParameters.instrumentUrls).thenAnswer((_) => instrumentUrlsParameter);
      final value = repository.getInstrumentUrls();
      expect(value == instrumentUrlsParameter.value, true);
    });

    test(" get() called", () async {
      final timeBetweenInterstitialParameter = TimeBetweenIntersitialsParameter();
      when(() => mockRemoteConfigParameters.timeBetweenInterstitials).thenAnswer((realInvocation) => timeBetweenInterstitialParameter);
      final value = repository.getTimeBetweenInterstitials();
      expect(value == timeBetweenInterstitialParameter.value, true);
    });
  });
}
