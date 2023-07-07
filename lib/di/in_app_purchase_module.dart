// coverage:ignore-file
import 'package:cifraclub/data/clients/http/cifraclub_api_network_service.dart';
import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/repository/in_app_purchase_repository_impl.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InAppPurchaseModule {
  @singleton
  InAppPurchase getInAppPurchase() {
    return InAppPurchase.instance;
  }

  @singleton
  InAppPurchaseDataSource getInAppPurchaseDataSource(InAppPurchase inAppPurchase) {
    return InAppPurchaseDataSource(
      inAppPurchase: inAppPurchase,
    );
  }

  @singleton
  InAppPurchaseRepository getInAppPurchaseRepository(InAppPurchaseDataSource inAppPurchaseDataSource) {
    return InAppPurchaseRepositoryImpl(inAppPurchaseDataSource);
  }

  ValidatePurchase getValidatePurchase(
    GetCredential getCredential,
    PostPurchaseOrder postOrder,
    ValidatePurchaseRepository validatePurchaseRepository,
  ) {
    return ValidatePurchase(
      getCredential: getCredential,
      postOrder: postOrder,
      validatePurchaseRepository: validatePurchaseRepository,
    );
  }

  ValidatePurchaseDataSource getValidatePurchaseDataSource(CifraClubAPINetworkService networkService) {
    return ValidatePurchaseDataSource(networkService: networkService);
  }
}
