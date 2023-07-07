import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/subscription/models/order_dto.dart';
import 'package:cifraclub/data/subscription/models/post_order.dart';
import 'package:cifraclub/data/subscription/models/purchase_result_dto.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class OrderDataSource {
  final NetworkService networkService;
  final GetOperatingSystem getOperatingSystem;

  OrderDataSource({
    required this.networkService,
    required this.getOperatingSystem,
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

  Future<PurchaseResultDto> postOrder(PurchaseDetails purchaseDetails, {bool replaceCcidAccount = false}) async {
    final orderJson = PostOrder.fromPurchase(purchaseDetails, replaceCcidAccount: replaceCcidAccount)?.toJson();
    return _postOrder(orderJson);
  }

  Future<PurchaseResultDto> postOrderFromPersistedPurchase(PersistedPurchase persistedPurchase,
      {bool replaceCcidAccount = false}) async {
    PostOrder? postOrder;
    switch (getOperatingSystem()) {
      case OperatingSystem.windows:
      case OperatingSystem.linux:
      case OperatingSystem.macos:
      case OperatingSystem.web:
      case OperatingSystem.fuchsia:
      case OperatingSystem.unknown:
        logger?.sendNonFatalCrash(exception: "BadPlatform");
        continue android;
      android:
      case OperatingSystem.android:
        postOrder = PostOrder.android(
            productId: persistedPurchase.productId,
            confirmed: replaceCcidAccount,
            token: persistedPurchase.token ?? "",
            app: persistedPurchase.packageName);
      case OperatingSystem.ios:
        postOrder =
            PostOrder.ios(sandbox: kDebugMode, confirmed: replaceCcidAccount, token: persistedPurchase.token ?? "");
    }

    final orderJson = postOrder.toJson();
    return _postOrder(orderJson);
  }

  Future<PurchaseResultDto> _postOrder(Map<String, dynamic>? orderJson) async {
    if (orderJson == null) {
      return PurchaseResultDto.unknown;
    }

    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/orders",
      data: orderJson,
      parser: (_) => null, // coverage:ignore-line
    );
    final result = await networkService.execute(request: request);

    if (result.isSuccess) {
      return PurchaseResultDto.success;
    } else {
      if (result.getError()! is ConnectionError) {
        return PurchaseResultDto.requestError;
      }

      if (result.getError()! is ServerError) {
        final serverError = result.getError()! as ServerError;
        final purchaseResultDto = _intToPurchaseResultDto(serverError.statusCode);

        if (purchaseResultDto == null) {
          // coverage:ignore-start
          logger?.sendNonFatalCrash(
            exception: "Unknown purchase validate result",
            information: [serverError.statusCode.toString()],
          );
          // coverage:ignore-end
        }
        return purchaseResultDto ?? PurchaseResultDto.unknown;
      }

      // coverage:ignore-start
      logger?.sendNonFatalCrash(
        exception: "Unknown purchase validate result",
        information: [result.getError()!.toString()],
      );
      // coverage:ignore-end
      return PurchaseResultDto.unknown;
    }
  }

  PurchaseResultDto? _intToPurchaseResultDto(int? value) {
    if (value == null) {
      return null;
    }
    if (value == 204) {
      return PurchaseResultDto.success;
    }
    if (value == 400) {
      return PurchaseResultDto.invalidParams;
    }
    if (value == 401) {
      return PurchaseResultDto.userNotLogged;
    }
    if (value == 409) {
      return PurchaseResultDto.tokenAlreadyValidated;
    }
    if (value == 424) {
      return PurchaseResultDto.paymentError;
    }
    if (value >= 500) {
      return PurchaseResultDto.serverError;
    }
    return null;
  }
}
