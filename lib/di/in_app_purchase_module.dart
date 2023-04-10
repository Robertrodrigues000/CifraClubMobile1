// coverage:ignore-file
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/repository/in_app_purchase_repository_impl.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InAppPurchaseModule {
  @singleton
  InAppPurchase getInAppPurchase() {
    return InAppPurchase.instance;
  }

  InAppPurchaseDataSource getInAppPurchaseDataSource(InAppPurchase inAppPurchase) {
    return InAppPurchaseDataSource(
      inAppPurchase: inAppPurchase,
    );
  }

  InAppPurchaseRepository getInAppPurchaseRepository(InAppPurchaseDataSource inAppPurchaseDataSource) {
    return InAppPurchaseRepositoryImpl(
      inAppPurchaseDataSource,
    );
  }
}
