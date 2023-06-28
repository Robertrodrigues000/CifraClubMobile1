import 'dart:io';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/data/subscription/models/purchase_result_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

// ignore: prefer_void_to_null
class _NetworkRequestMock extends Fake implements NetworkRequest<Null> {}

void main() {
  group("When called `getUserOrders`", () {
    setUpAll(() {
      registerFallbackValue(_NetworkRequestMock());
    });

    test("When request is success should return list orderDto", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/subscription/data_source/orders_mock_json_response.json").readAsString();
      await networkService.mock<List<OrderDto>>(response: mockResponse);

      final dataSource = OrderDataSource(networkService: networkService);

      final result = await dataSource.getUserOrders();

      final request = verify(() => networkService.execute<List<OrderDto>>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<List<OrderDto>>;

      expect(request.path, "/v3/orders");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, {"product": "pro"});

      expect(result.isSuccess, isTrue);
      expect(result.get()!.first.sku, "cifraclub_pro_anual_2021");
      expect(result.get()!.first.status, 0);
      expect(result.get()!.first.expirationDate, "2023-03-15");
      expect(result.get()!.length, 1);
    });

    test("When request is failure should return server error", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<List<OrderDto>>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError(statusCode: 404))),
      );

      final dataSource = OrderDataSource(networkService: networkService);

      final result = await dataSource.getUserOrders();

      expect(result.isFailure, isTrue);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });

  group("When called `postOrder`", () {
    test("When send google play order", () async {
      final networkService = NetworkServiceMock();
      final dataSource = OrderDataSource(networkService: networkService);

      registerFallbackValue(_NetworkRequestMock());

      // ignore: prefer_void_to_null
      when(() => networkService.execute<Null>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final order = GooglePlayPurchaseDetails(
        productID: "",
        verificationData: PurchaseVerificationData(localVerificationData: "", serverVerificationData: "", source: ""),
        transactionDate: "",
        billingClientPurchase: const PurchaseWrapper(
          orderId: "",
          packageName: "",
          purchaseTime: 12,
          purchaseToken: "",
          signature: "",
          skus: [],
          isAutoRenewing: true,
          originalJson: "",
          isAcknowledged: true,
          purchaseState: PurchaseStateWrapper.purchased,
        ),
        status: PurchaseStatus.purchased,
      );

      final result = await dataSource.postOrder(order);

      // ignore: prefer_void_to_null
      final request = verify(() => networkService.execute<Null>(request: captureAny(named: "request"))).captured.first
          // ignore: prefer_void_to_null
          as NetworkRequest<Null>;

      expect(request.path, "/v3/orders");
      expect(request.type, NetworkRequestType.post);

      expect(result, PurchaseResultDto.success);
    });

    test("When send app store order", () async {
      final networkService = NetworkServiceMock();
      final dataSource = OrderDataSource(networkService: networkService);

      registerFallbackValue(_NetworkRequestMock());

      // ignore: prefer_void_to_null
      when(() => networkService.execute<Null>(request: captureAny(named: "request"))).thenAnswer(
        (_) => SynchronousFuture(const Ok(null)),
      );

      final order = AppStorePurchaseDetails(
        productID: "",
        verificationData: PurchaseVerificationData(localVerificationData: "", serverVerificationData: "", source: ""),
        transactionDate: "",
        status: PurchaseStatus.purchased,
        skPaymentTransaction: SKPaymentTransactionWrapper(
          payment: const SKPaymentWrapper(productIdentifier: ""),
          transactionState: SKPaymentTransactionStateWrapper.purchased,
        ),
      );

      final result = await dataSource.postOrder(order);

      // ignore: prefer_void_to_null
      final request = verify(() => networkService.execute<Null>(request: captureAny(named: "request"))).captured.first
          // ignore: prefer_void_to_null
          as NetworkRequest<Null>;

      expect(request.path, "/v3/orders");
      expect(request.type, NetworkRequestType.post);

      expect(result, PurchaseResultDto.success);
    });

    test("When request fail", () async {
      final networkService = NetworkServiceMock();
      final dataSource = OrderDataSource(networkService: networkService);

      registerFallbackValue(_NetworkRequestMock());

      final errors = [
        ConnectionError(),
        ServerError(statusCode: 204),
        ServerError(statusCode: 400),
        ServerError(statusCode: 401),
        ServerError(statusCode: 409),
        ServerError(statusCode: 424),
        ServerError(statusCode: 500),
        ServerError(),
      ];

      final expectedResult = [
        PurchaseResultDto.requestError,
        PurchaseResultDto.success,
        PurchaseResultDto.invalidParams,
        PurchaseResultDto.userNotLogged,
        PurchaseResultDto.tokenAlreadyValidated,
        PurchaseResultDto.paymentError,
        PurchaseResultDto.serverError,
        PurchaseResultDto.unknown,
      ];

      for (var i = 0; i < errors.length; i++) {
        // ignore: prefer_void_to_null
        when(() => networkService.execute<Null>(request: captureAny(named: "request"))).thenAnswer(
          (_) => SynchronousFuture(Err(errors[i])),
        );

        final order = AppStorePurchaseDetails(
          productID: "",
          verificationData: PurchaseVerificationData(localVerificationData: "", serverVerificationData: "", source: ""),
          transactionDate: "",
          status: PurchaseStatus.purchased,
          skPaymentTransaction: SKPaymentTransactionWrapper(
              payment: const SKPaymentWrapper(productIdentifier: ""),
              transactionState: SKPaymentTransactionStateWrapper.purchased),
        );

        final result = await dataSource.postOrder(order);

        expect(result, expectedResult[i]);
      }
    });
  });
}
