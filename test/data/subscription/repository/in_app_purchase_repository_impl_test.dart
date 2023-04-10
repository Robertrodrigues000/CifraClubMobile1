import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/repository/in_app_purchase_repository_impl.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
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
  });

  setUp(() {
    clearInteractions(inAppPurchaseDataSource);
    when(inAppPurchaseDataSource.cleanIosTransactions).thenAnswer((_) => SynchronousFuture(null));
    when(() => inAppPurchaseDataSource.ensureInitialized).thenAnswer((_) => SynchronousFuture(true));
    when(inAppPurchaseDataSource.getPurchaseStream).thenAnswer((_) => const Stream.empty());
  });

  PurchaseDetails getPurchase(PurchaseStatus status, {required bool pending}) {
    return PurchaseDetails(
        purchaseID: "",
        productID: "",
        verificationData: PurchaseVerificationData(localVerificationData: "", serverVerificationData: "", source: ""),
        transactionDate: "",
        status: status)
      ..pendingCompletePurchase = pending;
  }

  test(
      "When `InAppPurchaseRepository` is created, it should wait for the datasource to start and then subscribe to purchase stream",
      () async {
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);
    verify(() => inAppPurchaseDataSource.ensureInitialized).called(1);
    await inAppPurchaseRepository.ensureInitialized;
    verify(inAppPurchaseDataSource.getPurchaseStream).called(1);
  });

  test("When purchaseStream emit values, the repository should listen", () async {
    // ignore: close_sinks
    final purchaseStream = BehaviorSubject<List<PurchaseDetails>>();
    // ignore: close_sinks
    final stateStream = BehaviorSubject<InAppRepositoryStatus>();

    when(inAppPurchaseDataSource.getPurchaseStream).thenAnswer((invocation) => purchaseStream);
    final inAppPurchaseRepository = InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);

    inAppPurchaseRepository.addListener(() {
      stateStream.add(inAppPurchaseRepository.state);
    });

    expect(inAppPurchaseRepository.state, InAppRepositoryStatus.idle);

    purchaseStream.add([getPurchase(PurchaseStatus.pending, pending: true)]);
    expect(await stateStream.first, InAppRepositoryStatus.purchasing);

    purchaseStream.add([getPurchase(PurchaseStatus.canceled, pending: true)]);
    expect(await stateStream.firstWhere((element) => element != InAppRepositoryStatus.purchasing),
        InAppRepositoryStatus.idle);
    verify(inAppPurchaseDataSource.cleanIosTransactions).called(1);

    purchaseStream.add([getPurchase(PurchaseStatus.purchased, pending: true)]);
    expect(await stateStream.firstWhere((element) => element != InAppRepositoryStatus.idle),
        InAppRepositoryStatus.validating);
    expect(
        await stateStream.firstWhere((element) => element != InAppRepositoryStatus.validating),
        InAppRepositoryStatus
            .purchased); // Todo: Mocado no código. Mudar isso quando estivermos fazendo post no V3/orders
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
}
