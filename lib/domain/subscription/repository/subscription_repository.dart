import 'package:rxdart/rxdart.dart';

abstract class SubscriptionRepository {
  void updateProStatus({bool? remoteProStatus, bool? storeProStatus});
  BehaviorSubject<bool> getProStatusStream();
}
