import 'package:rxdart/rxdart.dart';

mixin SubscriptionHolder {
  final subscriptions = CompositeSubscription();

  void disposeAll() {
    subscriptions.dispose();
  }
}
