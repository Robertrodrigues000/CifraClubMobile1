import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';

abstract class PersistedPurchaseRepository {
  Future<void> setPersistedPurchase(PersistedPurchase persistedPurchase);
  Future<PersistedPurchase?> getPersistedPurchase();
}
