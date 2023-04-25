// coverage:ignore-file
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_remote_products.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart';
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class DevScreenBloc extends Cubit<DevScreenState> {
  final GetProducts _getProducts;
  final GetRemoteProductsIds _getRemoteProductsIds;
  final PurchaseProduct _purchaseProduct;
  final InAppPurchaseRepository _inAppPurchaseRepository;
  final GetOrders _getOrders;
  final PostPurchaseOrder _postPurchaseOrder;

  DevScreenBloc(
    this._getProducts,
    this._getRemoteProductsIds,
    this._purchaseProduct,
    this._inAppPurchaseRepository,
    this._getOrders,
    this._postPurchaseOrder,
  ) : super(const DevScreenState());

  void initPurchaseStream() {
    // ignore: avoid_print
    print("Starting purchase stream");
    // ignore: avoid_print
    _inAppPurchaseRepository.getPurchaseStream().listen(print);
  }

  Future<void> restorePurchases() {
    return _inAppPurchaseRepository.restorePurchases();
  }

  Future<void> getProducts() async {
    initPurchaseStream();
    await getOrders();
    final productIds = _getRemoteProductsIds();
    final products = await _getProducts(productIds.toSet());
    await _inAppPurchaseRepository.cleanIosTransactions();

    products.onSuccess(
      (products) {
        // ignore: avoid_print
        logger?.log(tag: runtimeType.toString(), message: "Purchasing ${products[1]}");
        _purchaseProduct(products[1]);
      },
    );
    // ignore: avoid_print
    products.onFailure(print);
  }

  Future<void> getOrders() async {
    final result = await _getOrders();

    // ignore: avoid_print
    result.onSuccess(print);
    // ignore: avoid_print
    result.onFailure(print);
  }

  Future<void> postOrder(Purchase purchase) async {
    final result = await _postPurchaseOrder(purchase);

    // ignore: avoid_print
    print(result);
  }
}
