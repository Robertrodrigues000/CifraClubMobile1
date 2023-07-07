// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/repository/persisted_purchase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PersistPurchase {
  final PersistedPurchaseRepository _persistedPurchaseRepository;

  PersistPurchase(this._persistedPurchaseRepository);

  Future<void> call(Purchase purchase) {
    return _persistedPurchaseRepository.setPersistedPurchase(PersistedPurchase(
      productId: purchase.productId,
      transactionDate: purchase.transactionDate,
      pendingCompletePurchase: purchase.pendingCompletePurchase,
      token: purchase.token,
      packageName: purchase.packageName,
    ));
  }
}
