// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';

@injectable
class PersistedPurchaseDataSource {
  Isar isar;
  PersistedPurchaseDataSource({
    required this.isar,
  });

  Future<void> setPersistedPurchase(PersistedPurchaseDto persistedPurchaseDto) {
    return isar.writeTxn(
      () async {
        isar.persistedPurchaseDtos.put(persistedPurchaseDto);
      },
    );
  }

  Future<PersistedPurchaseDto?> getPersistedPurchase() {
    return isar.persistedPurchaseDtos.get(PersistedPurchaseDto.persistedPurchaseId);
  }
}
