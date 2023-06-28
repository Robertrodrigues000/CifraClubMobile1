import 'package:cifraclub/data/remote_config/parameters/instrument_urls_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/list_limit_constants_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/remote_product_parameter.dart';
import 'package:cifraclub/data/remote_config/parameters/versions_limit_constants_parameter.dart';
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
  late RemoteConfigRegisteredParameters remoteConfigParametersMock;
  late FirebaseRemoteConfig mockFirebaseRemoteConfig;

  late RemoteConfigRepository repository;

  final remoteParams = [IntTestParam()];
  final testRemoteConfigParams = {remoteParams[0].remoteConfigKey: "7"};

  setUp(() {
    mockFirebaseRemoteConfig = FirebaseRemoteConfigMock.getDummy(
      remoteValues: testRemoteConfigParams,
    );

    remoteConfigParametersMock = _RemoteConfigRegisteredParametersMock();

    when(() => remoteConfigParametersMock.registeredParams).thenReturn(remoteParams);

    repository = RemoteConfigRepositoryImpl(
      remoteConfig: mockFirebaseRemoteConfig,
      remoteConfigParameters: remoteConfigParametersMock,
    );
  });

  test("When created, wasValuesFetched must be false", () {
    expect(repository.wasValuesFetched, isFalse);
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
      expect(repository.wasValuesFetched, isTrue);
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
      when(() => remoteConfigParametersMock.instrumentUrls).thenAnswer((_) => instrumentUrlsParameter);
      final value = repository.getInstrumentUrls();
      expect(value == instrumentUrlsParameter.value, true);
    });

    test(" getTimeBetweenInterstitials() called", () async {
      final timeBetweenInterstitialParameter = TimeBetweenIntersitialsParameter();
      when(() => remoteConfigParametersMock.timeBetweenInterstitials)
          .thenAnswer((realInvocation) => timeBetweenInterstitialParameter);
      final value = repository.getTimeBetweenInterstitials();
      expect(value == timeBetweenInterstitialParameter.value, true);
    });

    test(" getRemoteProducts() called", () async {
      final remoteProductParameter = RemoteProductParameter();
      when(() => remoteConfigParametersMock.products).thenAnswer((realInvocation) => remoteProductParameter);
      final value = repository.getProducts();
      expect(value == remoteProductParameter.value, true);
    });

    test(" getRemoteProductsIds() called", () async {
      final remoteProductParameter = RemoteProductParameter();
      when(() => remoteConfigParametersMock.products).thenAnswer((realInvocation) => remoteProductParameter);
      final value = repository.getProductsIds();
      expect(value.first == remoteProductParameter.value.first.id, true);
      expect(value.last == remoteProductParameter.value.last.id, true);
    });

    test(" getListLimitConstants() called", () async {
      final listLimitConstantsParameter = ListLimitConstantsParameter();
      when(() => remoteConfigParametersMock.listLimitConstants).thenAnswer((_) => listLimitConstantsParameter);
      final value = repository.getListLimitConstants();
      expect(value == listLimitConstantsParameter.value, true);
      expect(value.maxListsForFree == listLimitConstantsParameter.value.maxListsForFree, true);
      expect(value.maxListsForPro == listLimitConstantsParameter.value.maxListsForPro, true);
      expect(value.listWarningCountThreshold == listLimitConstantsParameter.value.listWarningCountThreshold, true);
    });

    test(" getVersionsLimitConstants() called", () async {
      final versionsLimitConstantsParameter = VersionsLimitConstantsParameter();
      when(() => remoteConfigParametersMock.tabsLimitConstants).thenAnswer((_) => versionsLimitConstantsParameter);
      final value = repository.getVersionsLimitConstants();
      expect(value.maxVersionsForFree == versionsLimitConstantsParameter.value.maxVersionsForFree, true);
      expect(value.maxVersionsForPro == versionsLimitConstantsParameter.value.maxVersionsForPro, true);
      expect(value.versionsWarningCountThreshold == versionsLimitConstantsParameter.value.versionsWarningCountThreshold,
          true);
    });
  });
}
