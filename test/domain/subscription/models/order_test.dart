import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("OrderStatus should have 8 possible values", () {
    expect(OrderStatus.values.length, 8);
  });
  test("isValid should be true in correct circumstances", () {
    var orderStatus = OrderStatus.statusActive;
    expect(orderStatus.isValid, isTrue);

    orderStatus = OrderStatus.statusTrial;
    expect(orderStatus.isValid, isTrue);

    orderStatus = OrderStatus.statusCancelled;
    expect(orderStatus.isValid, isTrue);

    orderStatus = OrderStatus.statusDeletedUser;
    expect(orderStatus.isValid, isFalse);

    orderStatus = OrderStatus.statusInactive;
    expect(orderStatus.isValid, isFalse);

    orderStatus = OrderStatus.statusMoved;
    expect(orderStatus.isValid, isFalse);

    orderStatus = OrderStatus.statusPending;
    expect(orderStatus.isValid, isFalse);

    orderStatus = OrderStatus.statusRefunded;
    expect(orderStatus.isValid, isFalse);
  });
}
