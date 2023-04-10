// coverage:ignore-file
import 'package:cifraclub/data/subscription/repository/subscription_repository_impl.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SubscriptionModule {
  @singleton
  SubscriptionRepository getSubscriptionRepository(InAppPurchaseRepository inAppPurchaseRepository) {
    return SubscriptionRepositoryImpl(inAppPurchaseRepository);
  }
}
