// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:cifraclub/domain/subscription/repository/order_repository.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:typed_result/typed_result.dart';

@injectable
class GetOrders {
  final OrderRepository _orderRepository;

  const GetOrders(this._orderRepository);

  Future<Result<List<Order>, RequestError>> call() {
    return _orderRepository.getOrders();
  }
}
