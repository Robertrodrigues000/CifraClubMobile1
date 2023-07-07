// coverage:ignore-file

import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/repository/persisted_purchase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPersistedPurchase {
  final PersistedPurchaseRepository _persistedPurchaseRepository;

  GetPersistedPurchase(this._persistedPurchaseRepository);

  Future<PersistedPurchase?> call() {
    return _persistedPurchaseRepository.getPersistedPurchase();
  }
}
