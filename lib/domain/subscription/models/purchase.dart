// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:cifraclub/domain/subscription/models/purchase_verification.dart';

enum Vendor {
  playStore,
  appStore,
}

class Purchase<T> {
  final String? purchaseId;
  final String productId;
  final PurchaseVerification verificationData;
  final String? transactionDate;
  final PurchaseState status;
  final PurchaseError? error;
  final bool pendingCompletePurchase;
  final Vendor? vendor;
  final String? token;
  final String? packageName;
  final T purchaseDto;
  // O objeto de domínio contém o dto dentro dele pois, em alguns momentos,
  // é necessário devolvê-lo para a lib de IAP.
  // Nesses casos, devolvemos o objeto original em vez de implementar um fromDomain()
  // para evitar problemas caso a lib altere a estrutura deste objeto algum dia.

  Purchase({
    required this.purchaseId,
    required this.productId,
    required this.verificationData,
    required this.transactionDate,
    required this.status,
    required this.error,
    required this.pendingCompletePurchase,
    this.vendor,
    this.token,
    this.packageName,
    required this.purchaseDto,
  });
}
