abstract class SubscriptionRepository {
  Future<bool> get ensureInitialized;
  Stream<bool> getProStatusStream();
}
