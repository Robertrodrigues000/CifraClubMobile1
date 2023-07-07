import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/validate_purchase_response.dart';
import 'package:typed_result/typed_result.dart';

abstract class ValidatePurchaseRepository {
  Future<Result<ValidatePurchaseResponse, RequestError>> postValidatePurchase({required Purchase purchase});
  Future<Result<ValidatePurchaseResponse, RequestError>> postValidatePersistedPurchase(
      {required PersistedPurchase purchase});
}
