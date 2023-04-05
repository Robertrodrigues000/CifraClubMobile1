import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable(createToJson: false)
class OrderDto extends Equatable {
  final String id;
  final int userId;
  final int status;
  final String orderStatus;
  final String paymentMethod;
  final String productGroup;
  @JsonKey(name: "product")
  final String sku;
  final String productType;
  final String expirationDate;
  final String activationDate;
  final String price;
  final String paymentClient;

  const OrderDto({
    required this.id,
    required this.userId,
    required this.status,
    required this.orderStatus,
    required this.paymentMethod,
    required this.productGroup,
    required this.sku,
    required this.productType,
    required this.expirationDate,
    required this.activationDate,
    required this.price,
    required this.paymentClient,
  });

  Order toDomain() => Order(
        status: _convertIntToOrderStatus(status),
        sku: sku,
        expirationDate: expirationDate,
      );

  OrderStatus _convertIntToOrderStatus(int status) {
    switch (status) {
      case 0:
        return OrderStatus.statusInactive;
      case 1:
        return OrderStatus.statusActive;
      case 2:
      case 3:
      case 4:
        return OrderStatus.statusPending;
      case 5:
        return OrderStatus.statusTrial;
      case 6:
        return OrderStatus.statusCancelled;
      case 7:
        return OrderStatus.statusRefunded;
      case 8:
        return OrderStatus.statusMoved;
      case 9:
        return OrderStatus.statusDeletedUser;
      default:
        return OrderStatus.statusInactive;
    }
  }

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

  // coverage:ignore-start
  @override
  List<Object?> get props => [id, userId, status, sku, expirationDate, price];
  // coverage:ignore-end
}
