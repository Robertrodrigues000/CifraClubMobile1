// coverage:ignore-file
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProStatusStream {
  final SubscriptionRepository _subscriptionRepository;

  const GetProStatusStream(this._subscriptionRepository);

  Stream<bool> call() => _subscriptionRepository.getProStatusStream();
}
