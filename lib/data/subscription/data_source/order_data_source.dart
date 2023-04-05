import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class OrderDataSource {
  NetworkService networkService;

  OrderDataSource({
    required this.networkService,
  });

  Future<Result<List<OrderDto>, RequestError>> getUserOrders() async {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/orders",
      queryParams: {"product": "pro"},
      parser: (data) => (data as List<dynamic>).map((e) => OrderDto.fromJson(e as Map<String, dynamic>)).toList(),
    );
    return networkService.execute(request: request);
  }
}
