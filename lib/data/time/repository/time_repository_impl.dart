import 'package:cifraclub/data/time/data_source/ntp_data_source.dart';
import 'package:cifraclub/domain/shared/request_result.dart';
import 'package:cifraclub/domain/time/repository/time_repository.dart';
import 'package:clock/clock.dart';

class TimeRepositoryImpl implements TimeRepository {
  final NtpDataSource ntpDataSource;
  final Clock clock;

  const TimeRepositoryImpl(this.ntpDataSource, this.clock);

  @override
  Future<RequestResult<DateTime>> getCurrentTime() async {
    final now = clock.now();
    try {
      final currentOffset = await ntpDataSource.getNtpOffset();
      return RequestResultLoaded(data: now.add(Duration(milliseconds: currentOffset)));
    } catch (e) {
      return RequestResultError(state: RequestResultState.connectionError, error: e);
    }
  }
}
