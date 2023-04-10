import 'dart:async';

import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _InAppPurchaseMock extends Mock implements InAppPurchase {}

void main() {
  test('When ensureInitialized is called, it should return the InAppPurchase lib isAvailable status', () async {
    final inAppPurchase = _InAppPurchaseMock();
    final completer = Completer<bool>();

    when(inAppPurchase.isAvailable).thenAnswer((_) => completer.future);

    final dataSource = InAppPurchaseDataSource(inAppPurchase: inAppPurchase);
    final future = dataSource.ensureInitialized;
    expect(future, isA<Future<void>>());
    completer.complete(true);
    await future;
    expect(completer.isCompleted, true);
    verify(inAppPurchase.isAvailable).called(1);
  });
  test('When restorePurchases is called should call the lib method', () async {
    final inAppPurchase = _InAppPurchaseMock();

    when(inAppPurchase.restorePurchases).thenAnswer((_) => SynchronousFuture(null));

    final dataSource = InAppPurchaseDataSource(inAppPurchase: inAppPurchase);
    await dataSource.restorePurchases();
    verify(inAppPurchase.restorePurchases).called(1);
  });

  test('When getProducts is called should return a list of products', () async {
    final inAppPurchase = _InAppPurchaseMock();

    final productDetails = ProductDetails(
        id: faker.animal.name(),
        title: faker.company.name(),
        description: faker.lorem.sentence(),
        price: faker.randomGenerator.string(50),
        rawPrice: faker.randomGenerator.decimal(),
        currencyCode: faker.currency.code());

    final productDetailsResponse = ProductDetailsResponse(notFoundIDs: [], productDetails: [productDetails]);

    when(() => inAppPurchase.queryProductDetails(any())).thenAnswer((_) => SynchronousFuture(productDetailsResponse));

    final dataSource = InAppPurchaseDataSource(inAppPurchase: inAppPurchase);
    final result = await dataSource.getProducts({""});

    expect(result.get()!, [productDetails]);
  });

  test('When getProducts fail should return IAPError', () async {
    final inAppPurchase = _InAppPurchaseMock();
    final iAPError = IAPError(source: "erro", code: "404", message: "Error");

    final productDetailsResponse = ProductDetailsResponse(
      notFoundIDs: [],
      productDetails: [],
      error: iAPError,
    );

    when(() => inAppPurchase.queryProductDetails(any())).thenAnswer((_) => SynchronousFuture(productDetailsResponse));

    final dataSource = InAppPurchaseDataSource(inAppPurchase: inAppPurchase);
    final result = await dataSource.getProducts({""});

    expect(result.getError()!.toString(), iAPError.toString());
  });
}
