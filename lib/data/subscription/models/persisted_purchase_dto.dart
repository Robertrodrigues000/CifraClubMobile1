import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'persisted_purchase_dto.g.dart';

@Collection(inheritance: false)
class PersistedPurchaseDto extends Equatable {
  static const persistedPurchaseId = 1;
  final Id id = persistedPurchaseId;
  final String? productId;
  final String? transactionDate;
  final bool? pendingCompletePurchase;
  final String? token;
  final String? packageName;

  const PersistedPurchaseDto({
    this.productId,
    this.transactionDate,
    this.pendingCompletePurchase,
    this.token,
    this.packageName,
  });

  PersistedPurchase toDomain() => PersistedPurchase(
        productId: productId,
        transactionDate: transactionDate,
        pendingCompletePurchase: pendingCompletePurchase,
        token: token,
        packageName: packageName,
      );

  PersistedPurchaseDto.fromDomain(PersistedPurchase persistedPurchase)
      : this(
          productId: persistedPurchase.productId,
          transactionDate: persistedPurchase.transactionDate,
          pendingCompletePurchase: persistedPurchase.pendingCompletePurchase,
          token: persistedPurchase.token,
          packageName: persistedPurchase.packageName,
        );

  @ignore
  @override
  List<Object?> get props => [productId, transactionDate, token, packageName, pendingCompletePurchase];
}
