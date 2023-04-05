import 'dart:io';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/subscription/data_source/order_data_source.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  group("When called `getUserOrders`", () {
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
}
