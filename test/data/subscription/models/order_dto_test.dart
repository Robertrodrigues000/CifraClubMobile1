import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("when `toDomain` is called should correctly convert to Order", () async {
    const orderDto = OrderDto(
      id: "41D7C",
      userId: 549746301,
      status: 0,
      orderStatus: "Inativo",
      paymentMethod: "",
      productGroup: "Anual",
      sku: "cifraclub_pro_anual_2021",
      productType: "pro",
      expirationDate: "2023-03-15",
      activationDate: "2023-03-15",
      price: "0",
      paymentClient: "google_play",
    );
    final order = orderDto.toDomain();

    expect(order.sku, orderDto.sku);
    expect(order.expirationDate, orderDto.expirationDate);
    expect(order.status, OrderStatus.statusInactive);
  });

  test("when `toDomain` is called should correctly convert to correctly status", () async {
    for (var i = 0; i < OrderStatus.values.length + 2; i++) {
      var orderDto = OrderDto(
        id: "41D7C",
        userId: 549746301,
        status: i,
        orderStatus: "Inativo",
        paymentMethod: "",
        productGroup: "Anual",
        sku: "cifraclub_pro_anual_2021",
        productType: "pro",
        expirationDate: "2023-03-15",
        activationDate: "2023-03-15",
        price: "0",
        paymentClient: "google_play",
      );
      final order = orderDto.toDomain();

      switch (i) {
        case 0:
          expect(order.status, OrderStatus.statusInactive);
          break;
        case 1:
          expect(order.status, OrderStatus.statusActive);
          break;
        case 2:
          expect(order.status, OrderStatus.statusPending);
          break;
        case 3:
          expect(order.status, OrderStatus.statusPending);
          break;
        case 4:
          expect(order.status, OrderStatus.statusPending);
          break;
        case 5:
          expect(order.status, OrderStatus.statusTrial);
          break;
        case 6:
          expect(order.status, OrderStatus.statusCancelled);
          break;
        case 7:
          expect(order.status, OrderStatus.statusRefunded);
          break;
        case 8:
          expect(order.status, OrderStatus.statusMoved);
          break;
        case 9:
          expect(order.status, OrderStatus.statusDeletedUser);
          break;
      }
    }
  });
}
