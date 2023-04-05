import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:typed_result/typed_result.dart';

abstract class OrderRepository {
  Future<Result<List<Order>, RequestError>> getOrders();
}
