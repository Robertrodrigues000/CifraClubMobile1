// coverage:ignore-file
import 'package:cifraclub/data/subscription/repository/subscription_repository_impl.dart';
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart';
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_orders.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart';
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SubscriptionModule {
  @singleton
  SubscriptionRepository getSubscriptionRepository(
    VerifyProStatus verifyProStatus,
    GetIsProPreference getIsProPreference,
    SetIsProPreference setIsProPreference,
  ) {
    return SubscriptionRepositoryImpl(
      verifyProStatus,
      getIsProPreference,
      setIsProPreference,
    );
  }

  GetRemoteProStatus getRemoteProStatus(GetOrders getOrders) {
    return GetRemoteProStatus(getOrders);
  }

  VerifyProStatus getVerifyProStatus() {
    return VerifyProStatus();
  }
}
