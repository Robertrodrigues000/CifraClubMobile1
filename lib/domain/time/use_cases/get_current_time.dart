// coverage:ignore-file
import 'package:cifraclub/domain/time/repository/time_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetCurrentTime {
  final TimeRepository timeRepository;

  const GetCurrentTime(this.timeRepository);

  Future<Result<DateTime, dynamic>> call() {
    return timeRepository.getCurrentTime();
  }
}
