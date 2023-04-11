// coverage:ignore-file
import 'package:cifraclub/data/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostPurchaseOrder {
  final OrderRepository _orderRepository;

  PostPurchaseOrder(this._orderRepository);

  Future<PurchaseResult> call(Purchase purchase, {bool replaceCcidAccount = false}) {
    return _orderRepository.postOrder(purchase);
  }
}
