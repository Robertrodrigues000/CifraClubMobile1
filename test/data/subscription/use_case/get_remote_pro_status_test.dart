import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _GetOrdersMock extends Mock implements GetOrders {}

void main() {
  test("When user is not logged in, should return false", () async {
    var getOrders = _GetOrdersMock();
    when(getOrders.call).thenAnswer((invocation) => SynchronousFuture(const Ok([])));
    var getRemoteProStatus = GetRemoteProStatus(getOrders);

    var isPro = await getRemoteProStatus(const UserCredential(isUserLoggedIn: false));

    expect(isPro, isFalse);
    verifyNever(getOrders.call);
  });
  test("When user is logged in and has no valid orders, should return false", () async {
    var getOrders = _GetOrdersMock();
    when(getOrders.call).thenAnswer((invocation) =>
        SynchronousFuture(const Ok([Order(status: OrderStatus.statusInactive, sku: "", expirationDate: "")])));
    var getRemoteProStatus = GetRemoteProStatus(getOrders);

    var isPro = await getRemoteProStatus(const UserCredential(isUserLoggedIn: true));

    expect(isPro, isFalse);
    verify(getOrders.call).called(1);
  });
  test("When user is logged in and has orders, should return true", () async {
    var getOrders = _GetOrdersMock();
    when(getOrders.call).thenAnswer((invocation) =>
        SynchronousFuture(const Ok([Order(status: OrderStatus.statusActive, sku: "", expirationDate: "")])));
    var getRemoteProStatus = GetRemoteProStatus(getOrders);

    var isPro = await getRemoteProStatus(const UserCredential(isUserLoggedIn: true));

    expect(isPro, isTrue);
    verify(getOrders.call).called(1);
  });
  test("When user is logged in and orders request fails, should return null", () async {
    var getOrders = _GetOrdersMock();
    when(getOrders.call).thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));
    var getRemoteProStatus = GetRemoteProStatus(getOrders);

    var isPro = await getRemoteProStatus(const UserCredential(isUserLoggedIn: true));

    expect(isPro, isNull);
    verify(getOrders.call).called(1);
  });
}
