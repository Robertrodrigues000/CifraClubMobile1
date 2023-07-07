import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/persist_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class ValidatePurchases {
  final ValidatePurchase _validatePurchase;
  final CompletePurchase _completePurchase;
  final PersistPurchase _persistPurchase;

  ValidatePurchases(this._validatePurchase, this._completePurchase, this._persistPurchase);

  Future<PurchaseResult> call(List<Purchase> purchases) async {
    purchases.sort((a, b) => int.parse(b.transactionDate ?? "0").compareTo(int.parse(a.transactionDate ?? "0")));

    // Pega só as compras mais recentes em debug, pois, em devices de teste, a quantidade de compras vai crescendo indefinidamente.
    if (kDebugMode) {
      purchases = purchases.take(5).toList();
    }
    var foundValidPurchase = false;
    var foundUnknownStatusPurchase = false;
    var foundAlreadyValidatedPurchase = false;

    for (final purchase in purchases) {
      var result = await _validatePurchase(purchase);
      if (result == PurchaseResult.valid) {
        foundValidPurchase = true;
        logger?.log(tag: runtimeType.toString(), message: "✅ found valid purchase");
        await _completePurchase(purchase);
        await _persistPurchase(purchase);
        break;
      }
      if (result == PurchaseResult.unknown) {
        logger?.log(tag: runtimeType.toString(), message: "💣 failed to validate");
        foundUnknownStatusPurchase = true;
      }
      if (result == PurchaseResult.tokenAlreadyValidated) {
        logger?.log(tag: runtimeType.toString(), message: "💥 tokenAlreadyValidated");
        foundAlreadyValidatedPurchase = true;
        await _persistPurchase(purchase);
      }
    }

    if (foundValidPurchase) {
      return PurchaseResult.valid;
    }

    if (foundAlreadyValidatedPurchase) {
      return PurchaseResult.tokenAlreadyValidated;
    }

    if (foundUnknownStatusPurchase) {
      return PurchaseResult.unknown;
    }

    return PurchaseResult.invalid;
  }
}
