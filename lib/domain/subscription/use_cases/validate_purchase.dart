import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:typed_result/typed_result.dart';

class ValidatePurchase {
  GetCredential getCredential;
  PostPurchaseOrder postOrder;
  ValidatePurchaseRepository validatePurchaseRepository;

  ValidatePurchase({
    required this.getCredential,
    required this.postOrder,
    required this.validatePurchaseRepository,
  });

  Future<PurchaseResult> call(Purchase purchase) async {
    if (getCredential()?.isUserLoggedIn ?? false) {
      logger?.log(tag: runtimeType.toString(), message: "Validating purchase for logged user");
      return postOrder(purchase);
    } else {
      logger?.log(tag: runtimeType.toString(), message: "Validating purchase for NOT logged user");
      var validatePurchaseResponse = await validatePurchaseRepository.postValidatePurchase(purchase: purchase);
      if (validatePurchaseResponse.isFailure) {
        logger?.log(tag: runtimeType.toString(), message: "Validate purchase Not logged - failed");
        return PurchaseResult.unknown;
      } else if (validatePurchaseResponse.get()!.isInGracePeriod || validatePurchaseResponse.get()!.isValid) {
        logger?.log(tag: runtimeType.toString(), message: "Validate purchase Not logged - IS VALID!");
        return PurchaseResult.valid;
      }
      logger?.log(tag: runtimeType.toString(), message: "Validate purchase Not logged - is NOT valid!");
      return PurchaseResult.invalid;
    }
  }
}
