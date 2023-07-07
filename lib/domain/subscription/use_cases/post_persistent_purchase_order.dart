// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostPersistentPurchaseOrder {
  final OrderRepository _orderRepository;

  PostPersistentPurchaseOrder(this._orderRepository);

  Future<PurchaseResult> call(PersistedPurchase purchase, {bool replaceCcidAccount = false}) {
    return _orderRepository.postOrderFromPersistedPurchase(purchase);
  }
}
