import 'package:cifraclub/data/subscription/data_source/order_data_source.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';
import 'package:cifraclub/data/subscription/models/purchase_result_dto.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/data/subscription/repository/order_repository_impl.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/subscription/models/order_mock.dart';
import '../../../shared_mocks/domain/subscription/models/persisted_purchase_mock.dart';
import '../../../shared_mocks/domain/subscription/models/purchase_mock.dart';

class _OrderDataSourceMock extends Mock implements OrderDataSource {}

class _OrderDtoMock extends Mock implements OrderDto {}

class _PurchaseDetailsMock extends Mock implements PurchaseDetails {}

void main() {
  setUpAll(() {
    registerFallbackValue(_PurchaseDetailsMock());
    registerFallbackValue(getFakePersistedPurchase());
    registerFallbackValue(PersistedPurchaseDto.fromDomain(getFakePersistedPurchase()));
  });

  group("When call `getUserOrders`", () {
    test("When request is success should return order list", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final order = getFakeOrder();
      final orderDto = _OrderDtoMock();

      when(orderDto.toDomain).thenReturn(order);

      when(dataSource.getUserOrders).thenAnswer((_) => SynchronousFuture(Ok([orderDto])));

      final result = await repository.getOrders();

      verify(orderDto.toDomain).called(1);

      expect(result.isSuccess, isTrue);
      expect(result.get(), [order]);
      expect(result.get()!.first, order);
    });

    test("When request is failure should return server error", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);

      when(dataSource.getUserOrders).thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

      final result = await repository.getOrders();

      expect(result.isFailure, isTrue);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When `postOrder` is called", () {
    test("When post with success should return success", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final purchase = getFakePurchase();

      when(() => dataSource.postOrder(captureAny())).thenAnswer((_) => SynchronousFuture(PurchaseResultDto.success));

      final result = await repository.postOrder(purchase);

      final params =
          verify(() => dataSource.postOrder(captureAny(), replaceCcidAccount: captureAny(named: "replaceCcidAccount")))
              .captured;

      expect(result, PurchaseResult.valid);
      expect(params.first, purchase.purchaseDto);
      expect(params.last, false);
    });

    test("When post is failure should return purchaseResult error", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final purchase = getFakePurchase();

      when(() => dataSource.postOrder(captureAny()))
          .thenAnswer((_) => SynchronousFuture(PurchaseResultDto.serverError));

      final result = await repository.postOrder(purchase);

      expect(result, PurchaseResult.unknown);
    });

    test("When post with success and change replace account value should return success", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final purchase = getFakePurchase();
      const replace = true;

      when(() => dataSource.postOrder(captureAny(), replaceCcidAccount: captureAny(named: "replaceCcidAccount")))
          .thenAnswer((_) => SynchronousFuture(PurchaseResultDto.success));

      final result = await repository.postOrder(purchase, replaceCcidAccount: replace);

      final params =
          verify(() => dataSource.postOrder(captureAny(), replaceCcidAccount: captureAny(named: "replaceCcidAccount")))
              .captured;

      expect(result, PurchaseResult.valid);
      expect(params.first, purchase.purchaseDto);
      expect(params.last, replace);
    });
  });

  group("When `postOrderFromPersistedPurchase` is called", () {
    test("When post with success should return success", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final purchase = getFakePersistedPurchase();

      when(() => dataSource.postOrderFromPersistedPurchase(captureAny()))
          .thenAnswer((_) => SynchronousFuture(PurchaseResultDto.success));

      final result = await repository.postOrderFromPersistedPurchase(purchase);

      final params = verify(() => dataSource.postOrderFromPersistedPurchase(captureAny(),
          replaceCcidAccount: captureAny(named: "replaceCcidAccount"))).captured;

      expect(result, PurchaseResult.valid);
      expect(params.first, purchase);
      expect(params.last, false);
    });

    test("When post is failure should return pruchaseResult error", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final purchase = getFakePersistedPurchase();

      when(() => dataSource.postOrderFromPersistedPurchase(captureAny()))
          .thenAnswer((_) => SynchronousFuture(PurchaseResultDto.serverError));

      final result = await repository.postOrderFromPersistedPurchase(purchase);

      expect(result, PurchaseResult.unknown);
    });

    test("When post with success and change replace account value should return success", () async {
      final dataSource = _OrderDataSourceMock();
      final repository = OrderRepositoryImpl(dataSource: dataSource);
      final purchase = getFakePersistedPurchase();
      const replace = true;

      when(() => dataSource.postOrderFromPersistedPurchase(captureAny(),
              replaceCcidAccount: captureAny(named: "replaceCcidAccount")))
          .thenAnswer((_) => SynchronousFuture(PurchaseResultDto.success));

      final result = await repository.postOrderFromPersistedPurchase(purchase, replaceCcidAccount: replace);

      final params = verify(() => dataSource.postOrderFromPersistedPurchase(captureAny(),
          replaceCcidAccount: captureAny(named: "replaceCcidAccount"))).captured;

      expect(result, PurchaseResult.valid);
      expect(params.first, purchase);
      expect(params.last, replace);
    });
  });
}
