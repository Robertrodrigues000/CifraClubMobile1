import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final OrderStatus status;
  final String sku;
  final String expirationDate;

  const Order({
    required this.status,
    required this.sku,
    required this.expirationDate,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [status, sku, expirationDate];
  // coverage:ignore-end
}

enum OrderStatus {
  statusInactive,
  statusActive,
  statusPending,
  statusTrial,
  statusCancelled,
  statusRefunded,
  statusMoved,
  statusDeletedUser;

  // coverage:ignore-start
  bool get isValid =>
      this == OrderStatus.statusActive || this == OrderStatus.statusTrial || this == OrderStatus.statusCancelled;
  // coverage:ignore-end
}
