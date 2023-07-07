import 'package:cifraclub/data/subscription/data_source/persisted_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/repository/persisted_purchase_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PersistedPurchaseRepository)
class PersistedPurchaseRepositoryImpl implements PersistedPurchaseRepository {
  final PersistedPurchaseDataSource _persistedPurchaseDataSource;

  PersistedPurchaseRepositoryImpl(this._persistedPurchaseDataSource);

  @override
  Future<void> setPersistedPurchase(PersistedPurchase persistedPurchase) {
    return _persistedPurchaseDataSource.setPersistedPurchase(PersistedPurchaseDto.fromDomain(persistedPurchase));
  }

  @override
  Future<PersistedPurchase?> getPersistedPurchase() async {
    return (await _persistedPurchaseDataSource.getPersistedPurchase())?.toDomain();
  }
}
