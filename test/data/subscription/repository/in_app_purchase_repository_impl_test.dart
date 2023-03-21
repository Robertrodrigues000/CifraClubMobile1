import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/repository/in_app_purchase_repository_impl.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _InAppPurchaseDataSourceMock extends Mock implements InAppPurchaseDataSource {}

void main() {
  test("When `getProducts` is Called should return List of products", () async {
    final inAppPurchaseDataSource = _InAppPurchaseDataSourceMock();
    final productDetails = ProductDetails(
      id: faker.animal.name(),
      title: faker.company.name(),
      description: faker.lorem.sentence(),
      price: faker.randomGenerator.string(50),
      rawPrice: faker.randomGenerator.decimal(),
      currencyCode: faker.currency.code(),
    );
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    when(() => inAppPurchaseDataSource.getProducts(any()))
        .thenAnswer((invocation) => SynchronousFuture(Ok([productDetails])));

    final result = await inAppPurchaseRepository.getProducts({""});

    expect(result.isSuccess, isTrue);
    expect(result.get()!.first.id, productDetails.id);
    expect(result.get()!.first.title, productDetails.title);
    expect(result.get()!.first.description, productDetails.description);
    expect(result.get()!.first.price, productDetails.price);
    expect(result.get()!.first.rawPrice, productDetails.rawPrice);
    expect(result.get()!.first.currencyCode, productDetails.currencyCode);
  });

  test("When `getProducts` fails should return error", () async {
    final inAppPurchaseDataSource = _InAppPurchaseDataSourceMock();
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);
    final iAPError = IAPError(source: "erro", code: "404", message: "error");

    when(() => inAppPurchaseDataSource.getProducts(any())).thenAnswer((invocation) => SynchronousFuture(Err(iAPError)));

    final result = await inAppPurchaseRepository.getProducts({""});

    expect(result.isSuccess, isFalse);
    expect(result.getError()!.code, iAPError.code);
    expect(result.getError()!.source, iAPError.source);
    expect(result.getError()!.message, iAPError.message);
  });
}
