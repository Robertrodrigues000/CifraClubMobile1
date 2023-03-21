// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:cifraclub/domain/subscription/models/purchase_verification.dart';

class Purchase {
  final String? purchaseId;
  final String productId;
  final PurchaseVerification verificationData;
  final String? transactionDate;
  final PurchaseState status;
  final PurchaseError? error;
  final bool pendingCompletePurchase;

  Purchase({
    required this.purchaseId,
    required this.productId,
    required this.verificationData,
    required this.transactionDate,
    required this.status,
    required this.error,
    required this.pendingCompletePurchase,
  });
}
