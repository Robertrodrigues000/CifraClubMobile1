import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_persistent_purchase_order.dart';
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class ValidatePersistedPurchase {
  final GetCredential _getCredential;
  final PostPersistentPurchaseOrder _postOrder;
  final ValidatePurchaseRepository _validatePurchaseRepository;
  final UpdateProStatusWithPurchaseResult _updateProStatusWithPurchaseResult;
  final GetPersistedPurchase _getPersistedPurchase;

  ValidatePersistedPurchase(
    this._getCredential,
    this._postOrder,
    this._validatePurchaseRepository,
    this._updateProStatusWithPurchaseResult,
    this._getPersistedPurchase,
  );

  Future<void> call() async {
    var purchase = await _getPersistedPurchase();
    PurchaseResult purchaseResult;

    if (purchase == null) {
      logger?.log(tag: runtimeType.toString(), message: "User doesnt have any persisted purchase");
      purchaseResult = PurchaseResult.invalid;
    } else if (_getCredential()?.isUserLoggedIn ?? false) {
      logger?.log(tag: runtimeType.toString(), message: "Validating persisted purchase for logged user");
      purchaseResult = await _postOrder(purchase);
    } else {
      logger?.log(tag: runtimeType.toString(), message: "Validating persisted purchase for NOT logged user");
      var validatePurchaseResponse =
          await _validatePurchaseRepository.postValidatePersistedPurchase(purchase: purchase);
      if (validatePurchaseResponse.isFailure) {
        logger?.log(tag: runtimeType.toString(), message: "Validate purchase Not logged - failed");
        purchaseResult = PurchaseResult.unknown;
      } else if (validatePurchaseResponse.get()!.isInGracePeriod || validatePurchaseResponse.get()!.isValid) {
        logger?.log(tag: runtimeType.toString(), message: "Validate persisted purchase Not logged - IS VALID!");
        purchaseResult = PurchaseResult.valid;
      } else {
        logger?.log(tag: runtimeType.toString(), message: "Validate persisted purchase Not logged - is NOT valid!");
        purchaseResult = PurchaseResult.invalid;
      }
    }

    _updateProStatusWithPurchaseResult(purchaseResult);
  }
}
