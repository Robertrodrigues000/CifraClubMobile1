import 'package:cifraclub/data/subscription/data_source/order_data_source.dart';
import 'package:cifraclub/domain/subscription/models/order.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/order_repository.dart';
import 'package:injectable/injectable.dart' hide Order;
import 'package:typed_result/typed_result.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl({required this.dataSource});

  @override
  Future<Result<List<Order>, RequestError>> getOrders() async {
    return (await dataSource.getUserOrders()).map((value) => value.map((e) => e.toDomain()).toList());
  }

  @override
  Future<PurchaseResult> postOrder(Purchase purchase, {bool replaceCcidAccount = false}) async {
    return (await dataSource.postOrder(purchase.purchaseDto, replaceCcidAccount: replaceCcidAccount)).toDomain();
  }

  @override
  Future<PurchaseResult> postOrderFromPersistedPurchase(PersistedPurchase purchase,
      {bool replaceCcidAccount = false}) async {
    return (await dataSource.postOrderFromPersistedPurchase(purchase, replaceCcidAccount: replaceCcidAccount))
        .toDomain();
  }
}
