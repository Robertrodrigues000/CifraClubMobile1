import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_input_dto.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/validate_purchase_response.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@Injectable(as: ValidatePurchaseRepository)
class ValidatePurchaseRepositoryImpl implements ValidatePurchaseRepository {
  final GetOperatingSystem getOperatingSystem;
  final ValidatePurchaseDataSource validatePurchaseDataSource;

  ValidatePurchaseRepositoryImpl({
    required this.getOperatingSystem,
    required this.validatePurchaseDataSource,
  });

  @override
  Future<Result<ValidatePurchaseResponse, RequestError>> postValidatePurchase({required Purchase purchase}) async {
    final validatePurchaseInputDto = _getValidatePurchaseInput(
      receipt: purchase.token ?? "",
      productId: purchase.productId,
      packageName: purchase.packageName,
      confirmed: (!purchase.pendingCompletePurchase).toString(),
    );
    return (await validatePurchaseDataSource.postValidatePurchase(validatePurchaseInputDto)).map((e) => e.toDomain());
  }

  @override
  Future<Result<ValidatePurchaseResponse, RequestError>> postValidatePersistedPurchase(
      {required PersistedPurchase purchase}) async {
    final validatePurchaseInputDto = _getValidatePurchaseInput(
      receipt: purchase.token ?? "",
      productId: purchase.productId ?? "",
      packageName: purchase.packageName,
      confirmed: (!(purchase.pendingCompletePurchase ?? true)).toString(),
    );
    return (await validatePurchaseDataSource.postValidatePurchase(validatePurchaseInputDto)).map((e) => e.toDomain());
  }

  ValidatePurchaseInputDto _getValidatePurchaseInput({
    required String receipt,
    required String productId,
    required String? packageName,
    required String confirmed,
  }) {
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
        return ValidatePurchaseInputDto.fromAndroid(
          platform: "android",
          token: receipt,
          app: packageName,
          productId: productId,
          confirmed: confirmed,
          productType: _getProductType(productId),
        );
      case OperatingSystem.ios:
        return ValidatePurchaseInputDto.fromiOS(platform: "ios", receipt: receipt, sandbox: kDebugMode);
    }
  }

  String _getProductType(String productId) {
    if (productId == "patrocine_custom") {
      return "inapp";
    }
    return "subs";
  }
}
