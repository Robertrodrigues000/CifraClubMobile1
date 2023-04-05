import 'package:cifraclub/data/subscription/data_source/order_data_source.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/data/subscription/repository/order_repository_impl.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/subscription/models/order_mock.dart';

class _OrderDataSourceMock extends Mock implements OrderDataSource {}

class _OrderDtoMock extends Mock implements OrderDto {}

void main() {
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
}
