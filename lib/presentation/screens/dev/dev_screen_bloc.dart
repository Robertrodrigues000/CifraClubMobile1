// coverage:ignore-file

import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_products.dart';
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class DevScreenBloc extends Cubit<DevScreenState> {
  DevScreenBloc(this._getProducts, this._purchaseProduct, this._inAppPurchaseRepository)
      : super(const DevScreenState());
  final GetProducts _getProducts;
  final PurchaseProduct _purchaseProduct;
  final InAppPurchaseRepository _inAppPurchaseRepository;

  void initPurchaseStream() {
    // ignore: avoid_print
    print("Starting purchase stream");
    _inAppPurchaseRepository.getPurchaseStream().listen((event) {
      // ignore: avoid_print
      print(event);
      _inAppPurchaseRepository.completePurchase(event[0]);
    });
  }

  Future<void> getProducts() async {
    // final productsIds = {"cifraclub_pro_mensal_2021", "cifraclub_pro_anual_2021"}; // Android
    final productsIds = {"cifra_club_pro_mensal"}; // iOS

    final products = await _getProducts(productsIds);

    await _inAppPurchaseRepository.cleanIosTransactions();

    products.onSuccess(
      (products) {
        // ignore: avoid_print
        print("Purchasing ${products[0]}");
        _purchaseProduct(products[0]);
      },
    );
    // ignore: avoid_print
    products.onFailure(print);
  }
}
