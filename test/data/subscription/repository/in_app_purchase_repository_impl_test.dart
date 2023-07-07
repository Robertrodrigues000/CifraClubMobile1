import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/repository/in_app_purchase_repository_impl.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:cifraclub/domain/subscription/models/purchase_verification.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/subscription/models/product_mock.dart';
import '../../../shared_mocks/domain/subscription/models/purchase_mock.dart';

class _InAppPurchaseDataSourceMock extends Mock implements InAppPurchaseDataSource {}

void main() {
  final inAppPurchaseDataSource = _InAppPurchaseDataSourceMock();
  setUpAll(() {
    registerFallbackValue(
      PurchaseDetails(
        productID: "",
        status: PurchaseStatus.canceled,
        transactionDate: "",
        verificationData: PurchaseVerificationData(
          localVerificationData: "",
          serverVerificationData: "",
          source: "",
        ),
      ),
    );

    registerFallbackValue(
      ProductDetails(
        id: "",
        title: "",
        description: "",
        price: "",
        rawPrice: 0,
        currencyCode: "",
      ),
    );

    registerFallbackValue(Purchase<dynamic>(
      purchaseId: "",
      productId: "",
      verificationData: PurchaseVerification(localVerificationData: "", serverVerificationData: "", source: ""),
      transactionDate: "",
      status: PurchaseState.error,
      error: PurchaseError(source: "", code: "", message: ""),
      pendingCompletePurchase: true,
      purchaseDto: GooglePlayPurchaseDetails(
        productID: "",
        verificationData: PurchaseVerificationData(localVerificationData: "", serverVerificationData: "", source: ""),
        transactionDate: "",
        billingClientPurchase: const PurchaseWrapper(
          orderId: "",
          packageName: "",
          purchaseTime: 12,
          purchaseToken: "",
          signature: "",
          products: [],
          isAutoRenewing: true,
          originalJson: "",
          isAcknowledged: true,
          purchaseState: PurchaseStateWrapper.purchased,
        ),
        status: PurchaseStatus.purchased,
      ),
    ));
  });

  setUp(() {
    clearInteractions(inAppPurchaseDataSource);
    when(inAppPurchaseDataSource.cleanIosTransactions).thenAnswer((_) => SynchronousFuture(null));
    when(() => inAppPurchaseDataSource.ensureInitialized).thenAnswer((_) => SynchronousFuture(true));
    when(inAppPurchaseDataSource.getPurchaseStream).thenAnswer((_) => const Stream.empty());
  });

  test("When `InAppPurchaseRepository` is created, it should wait for the datasource to start.", () async {
    // ignore: unused_local_variable
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);
    verify(() => inAppPurchaseDataSource.ensureInitialized).called(1);
  });

  test("When `getProducts` is called should return List of products", () async {
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
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);
    final iAPError = IAPError(source: "erro", code: "404", message: "error");

    when(() => inAppPurchaseDataSource.getProducts(any())).thenAnswer((invocation) => SynchronousFuture(Err(iAPError)));

    final result = await inAppPurchaseRepository.getProducts({""});

    expect(result.isSuccess, isFalse);
    expect(result.getError()!.code, iAPError.code);
    expect(result.getError()!.source, iAPError.source);
    expect(result.getError()!.message, iAPError.message);
  });

  test("When `purchaseProduct` is called, should call the data source method", () async {
    final product = getFakeProduct();
    when(() => inAppPurchaseDataSource.purchaseProduct(any())).thenAnswer((invocation) => Future.value(true));
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    inAppPurchaseRepository.purchaseProduct(product);

    final productDetails =
        verify(() => inAppPurchaseDataSource.purchaseProduct(captureAny())).captured.first as ProductDetails;

    expect(productDetails.id, product.id);
    expect(productDetails.currencyCode, product.currencyCode);
    expect(productDetails.currencySymbol, product.currencySymbol);
    expect(productDetails.description, product.description);
    expect(productDetails.price, product.price);
    expect(productDetails.rawPrice, product.rawPrice);
    expect(productDetails.title, product.title);
  });

  test("When `completePurchase` is called, should call the data source method", () async {
    final purchase = getFakePurchase();
    when(() => inAppPurchaseDataSource.completePurchase(any())).thenAnswer((invocation) => Future.value());
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    inAppPurchaseRepository.completePurchase(purchase);

    final purchaseDetails =
        verify(() => inAppPurchaseDataSource.completePurchase(captureAny())).captured.first as PurchaseDetails;

    expect(purchaseDetails.pendingCompletePurchase, purchase.pendingCompletePurchase);
    expect(purchaseDetails.productID, purchase.productId);
    expect(purchaseDetails.purchaseID, purchase.purchaseId);
    expect(purchaseDetails.transactionDate, purchase.transactionDate);
    expect(purchaseDetails.verificationData.localVerificationData, purchase.verificationData.localVerificationData);
    expect(purchaseDetails.verificationData.serverVerificationData, purchase.verificationData.serverVerificationData);
    expect(purchaseDetails.verificationData.source, purchase.verificationData.source);
  });

  test("When `cleanIosTransactions` is called, should call the data source method", () async {
    when(inAppPurchaseDataSource.cleanIosTransactions).thenAnswer((invocation) => Future.value());
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    inAppPurchaseRepository.cleanIosTransactions();

    verify(inAppPurchaseDataSource.cleanIosTransactions).called(1);
  });
  test("When `restorePurchases` is called, should call the data source method", () async {
    when(inAppPurchaseDataSource.restorePurchases).thenAnswer((invocation) => Future.value());
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    inAppPurchaseRepository.restorePurchases();

    verify(inAppPurchaseDataSource.restorePurchases).called(1);
  });

  test("When `getPurchaseStream` is called, should call the data source method", () async {
    when(inAppPurchaseDataSource.getPurchaseStream).thenAnswer((invocation) => Stream.value([]));
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    inAppPurchaseRepository.getPurchaseStream();

    verify(inAppPurchaseDataSource.getPurchaseStream).called(1);
  });
}
