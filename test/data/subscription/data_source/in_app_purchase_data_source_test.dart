import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _InAppPurchaseMock extends Mock implements InAppPurchase {}

void main() {
  testWidgets('When getProducts is called should return a list of products', (tester) async {
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

  testWidgets('When getProducts fail should return IAPError', (tester) async {
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
