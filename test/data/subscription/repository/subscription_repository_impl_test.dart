import 'package:cifraclub/data/subscription/repository/subscription_repository_impl.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Notifier extends ValueNotifier {
  _Notifier() : super(null);
}

class _InAppPurchaseRepositoryMock extends Mock implements InAppPurchaseRepository {
  final internalNotifier = _Notifier();
}

void main() {
  final inAppPurchaseRepository = _InAppPurchaseRepositoryMock();

  setUp(() {
    clearInteractions(inAppPurchaseRepository);
    when(inAppPurchaseRepository.cleanIosTransactions).thenAnswer((_) => SynchronousFuture(null));
    when(inAppPurchaseRepository.restorePurchases).thenAnswer((_) => SynchronousFuture(null));
    when(() => inAppPurchaseRepository.ensureInitialized).thenAnswer((_) => SynchronousFuture(true));
    when(inAppPurchaseRepository.getPurchaseStream).thenAnswer((_) => const Stream.empty());
    when(() => inAppPurchaseRepository.addListener(any())).thenAnswer((invocation) {
      inAppPurchaseRepository.internalNotifier.addListener(invocation.positionalArguments[0]);
    });
  });

  test(
      "When `SubscriptionRepository` is created, it should wait for the InAppPurchaseRepository to start and then subscribe to purchase stream and restore user`s purchases",
      () async {
    final subscriptionRepository = SubscriptionRepositoryImpl(inAppPurchaseRepository);
    verify(() => inAppPurchaseRepository.ensureInitialized).called(1);
    await subscriptionRepository.ensureInitialized;
    verify(() => inAppPurchaseRepository.addListener(any())).called(1);
  });

  test("When a purchase is received, the SubscriptionRepository should update the pro status accordingly", () async {
    final subscriptionRepository = SubscriptionRepositoryImpl(inAppPurchaseRepository);
    var streamCounter = 0;

    subscriptionRepository.getProStatusStream().listen((_) {
      streamCounter++;
    });

    expect(await subscriptionRepository.getProStatusStream().first, isFalse);

    expect(streamCounter, 1);

    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.idle);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    expect(await subscriptionRepository.getProStatusStream().first, isFalse);

    expect(streamCounter, 1);

    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.purchased);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    expect(await subscriptionRepository.getProStatusStream().first, isTrue);
    expect(streamCounter, 2);

    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.idle);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.validationRequestError);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.serverError);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.purchasing);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.purchaseRequestError);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    expect(await subscriptionRepository.getProStatusStream().first, isTrue);
    expect(streamCounter, 2);

    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.deniedByApi);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    expect(await subscriptionRepository.getProStatusStream().first, isFalse);
    expect(streamCounter, 3);
    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.tokenAlreadyValidated);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    expect(await subscriptionRepository.getProStatusStream().first, isFalse);
    expect(streamCounter, 4);
    when(() => inAppPurchaseRepository.state).thenReturn(InAppRepositoryStatus.paymentDenied);
    inAppPurchaseRepository.internalNotifier.notifyListeners();
    expect(await subscriptionRepository.getProStatusStream().first, isFalse);
    expect(streamCounter, 5);
  });
}
