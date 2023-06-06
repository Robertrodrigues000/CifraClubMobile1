import 'package:cifraclub/data/subscription/repository/subscription_repository_impl.dart';
import 'package:cifraclub/domain/preferences/use_case/get_is_pro_preference.dart';
import 'package:cifraclub/domain/preferences/use_case/set_is_pro_preference.dart';
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _VerifyProStatusMock extends Mock implements VerifyProStatus {}

class _SetIsProPreferenceMock extends Mock implements SetIsProPreference {}

class _GetIsProPreferenceMock extends Mock implements GetIsProPreference {}

void main() {
  final setIsProPreference = _SetIsProPreferenceMock();
  final getIsProPreference = _GetIsProPreferenceMock();

  setUp(() {
    when(() => setIsProPreference(any())).thenAnswer((_) => SynchronousFuture(true));
    when(getIsProPreference).thenReturn(false);
  });
  test("When updateProStatus is called, should call verifyProStatus accordingly", () {
    var verifyProStatus = _VerifyProStatusMock();
    _mockVerifyProStatus(verifyProStatus, false);

    var subscriptionRepository = SubscriptionRepositoryImpl(verifyProStatus, getIsProPreference, setIsProPreference);

    subscriptionRepository.updateProStatus();
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: null, storeProStatus: null, currentProStatus: false);

    subscriptionRepository.updateProStatus(remoteProStatus: true);
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: true, storeProStatus: null, currentProStatus: false);

    // should store the last value of remoteProStatus
    subscriptionRepository.updateProStatus();
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: true, storeProStatus: null, currentProStatus: false);

    subscriptionRepository.updateProStatus(remoteProStatus: false);
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: false, storeProStatus: null, currentProStatus: false);

    subscriptionRepository.updateProStatus(storeProStatus: true);
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: false, storeProStatus: true, currentProStatus: false);

    // should store the last value of storeProStatus
    subscriptionRepository.updateProStatus();
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: false, storeProStatus: true, currentProStatus: false);

    subscriptionRepository.updateProStatus(storeProStatus: false);
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: false, storeProStatus: false, currentProStatus: false);

    subscriptionRepository.updateProStatus(remoteProStatus: true, storeProStatus: true);
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: true, storeProStatus: true, currentProStatus: false);

    when(getIsProPreference).thenReturn(true);

    subscriptionRepository = SubscriptionRepositoryImpl(verifyProStatus, getIsProPreference, setIsProPreference);

    subscriptionRepository.updateProStatus(remoteProStatus: true, storeProStatus: true);
    _expectVerifyProStatus(verifyProStatus, remoteProStatus: true, storeProStatus: true, currentProStatus: true);
  });

  test("When updateProStatus is called, the proStream should emit values accordingly", () {
    var verifyProStatus = _VerifyProStatusMock();

    _mockVerifyProStatus(verifyProStatus, false);
    var subscriptionRepository =
        SubscriptionRepositoryImpl(verifyProStatus, getIsProPreference, setIsProPreference); // should emit false

    expect(
        subscriptionRepository.getProStatusStream(),
        emitsInOrder([
          isFalse,
          isTrue,
          isFalse,
        ]));

    _mockVerifyProStatus(verifyProStatus, true);
    subscriptionRepository.updateProStatus(); // should emit true

    subscriptionRepository.updateProStatus(); // repeated value, should not emit
    subscriptionRepository.updateProStatus(); // repeated value, should not emit

    _mockVerifyProStatus(verifyProStatus, false);
    subscriptionRepository.updateProStatus(); // should emit false
  });
}

void _mockVerifyProStatus(_VerifyProStatusMock verifyProStatus, bool proStatus) {
  reset(verifyProStatus);
  when(
    () => verifyProStatus.call(
      remoteProStatus: any(named: "remoteProStatus"),
      storeProStatus: any(named: "storeProStatus"),
      currentProStatus: any(named: "currentProStatus"),
    ),
  ).thenReturn(proStatus);
}

void _expectVerifyProStatus(_VerifyProStatusMock verifyProStatus,
    {bool? remoteProStatus, bool? storeProStatus, required bool currentProStatus}) {
  final captured = verify(
    () => verifyProStatus.call(
      remoteProStatus: captureAny(named: "remoteProStatus"),
      storeProStatus: captureAny(named: "storeProStatus"),
      currentProStatus: captureAny(named: "currentProStatus"),
    ),
  ).captured;

  final capturedRemoteProStatus = captured[0];
  final capturedStoreProStatus = captured[1];
  final capturedCurrentProStatus = captured[2];

  expect(capturedRemoteProStatus, remoteProStatus);
  expect(capturedStoreProStatus, storeProStatus);
  expect(capturedCurrentProStatus, currentProStatus);
  clearInteractions(verifyProStatus);
}
