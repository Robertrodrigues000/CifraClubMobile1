import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/data/subscription/models/post_order.dart';
import 'package:cifraclub/data/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
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

  Future<PurchaseResult> postOrder(PurchaseDetails purchaseDetails, {bool replaceCcidAccount = false}) async {
    final orderJson = PostOrder.fromPurchase(purchaseDetails, replaceCcidAccount: replaceCcidAccount)?.toJson();

    if (orderJson == null) {
      return PurchaseResult.unknown;
    }

    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/orders",
      data: orderJson,
      parser: (_) => null, // coverage:ignore-line
    );
    final result = await networkService.execute(request: request);

    if (result.isSuccess) {
      return PurchaseResult.success;
    } else {
      if (result.getError()! is ConnectionError) {
        return PurchaseResult.requestError;
      }

      if (result.getError()! is ServerError) {
        final serverError = result.getError()! as ServerError;
        final purchaseResult = _intToPurchaseResult(serverError.statusCode);

        if (purchaseResult == null) {
          // coverage:ignore-start
          logger?.sendNonFatalCrash(
            exception: "Unknown purchase validate result",
            information: [serverError.statusCode.toString()],
          );
          // coverage:ignore-end
        }
        return purchaseResult ?? PurchaseResult.unknown;
      }

      // coverage:ignore-start
      logger?.sendNonFatalCrash(
        exception: "Unknown purchase validate result",
        information: [result.getError()!.toString()],
      );
      // coverage:ignore-end
      return PurchaseResult.unknown;
    }
  }

  PurchaseResult? _intToPurchaseResult(int? value) {
    if (value == null) {
      return null;
    }
    if (value == 204) {
      return PurchaseResult.success;
    }
    if (value == 400) {
      return PurchaseResult.invalidParams;
    }
    if (value == 401) {
      return PurchaseResult.userNotLogged;
    }
    if (value == 409) {
      return PurchaseResult.tokenAlreadyValidated;
    }
    if (value == 424) {
      return PurchaseResult.paymentError;
    }
    if (value >= 500) {
      return PurchaseResult.serverError;
    }
    return null;
  }
}
