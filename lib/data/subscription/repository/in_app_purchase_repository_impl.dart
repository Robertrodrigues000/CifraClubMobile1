import 'dart:async';

import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/extension/subscription_domain_extension.dart';
import 'package:cifraclub/data/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:typed_result/typed_result.dart';

class InAppPurchaseRepositoryImpl extends ValueNotifier implements InAppPurchaseRepository {
  final InAppPurchaseDataSource _inAppPurchaseDataSource;
  final _initialized = Completer<bool>();
  StreamSubscription? inAppPurchaseStreamSubscription;

  @override
  InAppRepositoryStatus state = InAppRepositoryStatus.idle;

  // inAppPurchase plugin can handle several purchases requests.
  // this implementation must pick only the valid one to process.
  // Null if there is no purchase in progress
  Purchase? _purchaseInProgress;

  InAppPurchaseRepositoryImpl(this._inAppPurchaseDataSource) : super(null) {
    _inAppPurchaseDataSource.ensureInitialized.then((value) {
      // coverage:ignore-start
      assert(value, "Payment platform is not ready/available");
      if (!value) {
        logger?.sendNonFatalCrash(exception: Exception("Payment platform is not ready/available"));
      }
      // coverage:ignore-end
      inAppPurchaseStreamSubscription = getPurchaseStream().listen(_oninAppPurchaseDataSourceEvent);
      _initialized.complete(value);
    });
  }

  @override
  Future<bool> get ensureInitialized => _initialized.future;

  @override
  Future<Result<List<Product>, PurchaseError>> getProducts(Set<String> ids) async {
    final result = await _inAppPurchaseDataSource.getProducts(ids);
    return result.map((value) => value.map((e) => e.toDomain()).toList()).mapError((error) => error.toDomain());
  }

  @override
  Future<void> restorePurchases() => _inAppPurchaseDataSource.restorePurchases();

  @override
  Future<bool> purchaseProduct(Product product) {
    return _inAppPurchaseDataSource.purchaseProduct(ProductExtension.fromDomain(product));
  }

  @override
  Stream<List<Purchase>> getPurchaseStream() {
    return _inAppPurchaseDataSource.getPurchaseStream().map((event) => event.map((e) => e.toDomain()).toList());
  }

  @override
  Future<void> completePurchase(Purchase purchase) =>
      _inAppPurchaseDataSource.completePurchase(PurchaseExtension.fromDomain(purchase));

  // coverage:ignore-start
  @override
  Future<void> close() {
    return inAppPurchaseStreamSubscription?.cancel() ?? Future.value();
  }
  // coverage:ignore-end

  void _setState(InAppRepositoryStatus status, Purchase? purchaseData) {
    if (state != status || _purchaseInProgress?.purchaseId != purchaseData?.purchaseId) {
      _purchaseInProgress = purchaseData;
      state = status;
      notifyListeners();
    }
  }

  void _oninAppPurchaseDataSourceEvent(List<Purchase> purchases) async {
    logger?.log(tag: runtimeType.toString(), message: "Received purchases: $purchases");
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseState.error:
          if (_purchaseInProgress?.purchaseId == purchase.purchaseId && state != InAppRepositoryStatus.purchased) {
            cleanIosTransactions();
            _setState(InAppRepositoryStatus.idle, null);
          }
          break;
        case PurchaseState.idle:
          break;
        case PurchaseState.waitingBackendValidation:
          if (state != InAppRepositoryStatus.validating && state != InAppRepositoryStatus.purchased) {
            await _validateNewPurchase(purchase);
          }
          break;
        case PurchaseState.waitingStoreResponse:
          if (state != InAppRepositoryStatus.purchased) {
            _setState(InAppRepositoryStatus.purchasing, purchase);
          }
          break;
      }
    }
  }

  // coverage:ignore-start
  // ignore: unused_element
  Future<void> _validateNewPurchase(Purchase purchase, {bool replaceCcidAccount = false}) async {
    _setState(InAppRepositoryStatus.validating, purchase);
    const validation = PurchaseResult.success; // TODO: POST no v3/orders
    switch (validation) {
      case PurchaseResult.success:
        cleanIosTransactions();
        await _confirmPurchase(purchase);
        break;

      case PurchaseResult.paymentError:
        cleanIosTransactions();
        _setState(InAppRepositoryStatus.paymentDenied, purchase);
        break;

      // As transações do iOS não são limpas neste caso por serem tratadas no modal
      case PurchaseResult.tokenAlreadyValidated:
        _setState(InAppRepositoryStatus.tokenAlreadyValidated, purchase);
        break;

      case PurchaseResult.requestError:
        _setState(InAppRepositoryStatus.validationRequestError, purchase);
        break;

      case PurchaseResult.invalidParams:
      case PurchaseResult.userNotLogged:
      case PurchaseResult.serverError:
      case PurchaseResult.unknown:
        cleanIosTransactions();
        logger?.sendNonFatalCrash(
            exception:
                Exception("Could not validate purchase. ID= ${purchase.purchaseId} PurchaseResult= $validation"));
        _setState(InAppRepositoryStatus.serverError, purchase);
        break;
    }
  }
  // coverage:ignore-end

  Future<void> _confirmPurchase(Purchase purchase) async {
    // TODO: GET no v3/orders

    _setState(InAppRepositoryStatus.purchased, purchase); // Simulando servidor respondendo tudo OK com a compra
    //_setState(InAppRepositoryStatus.deniedByApi, purchase); // Simulando servidor respondendo que a compra não é válida
    //_setState(InAppRepositoryStatus.validationRequestError, purchase); // Simulando falha de conexão
    //_setState(InAppRepositoryStatus.serverError, purchase); // Simulando outro erro
  }

  @override
  Future<void> cleanIosTransactions() => _inAppPurchaseDataSource.cleanIosTransactions();
}
