import 'package:cifraclub/domain/shared/request_result.dart';
import 'package:cifraclub/domain/time/repository/time_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentTime {
  final TimeRepository timeRepository;

  const GetCurrentTime(this.timeRepository);

  Future<RequestResult<DateTime>> call() {
    return timeRepository.getCurrentTime();
  }
}
