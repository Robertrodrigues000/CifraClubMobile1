import 'package:cifraclub/data/time/data_source/ntp_data_source.dart';
import 'package:cifraclub/domain/time/repository/time_repository.dart';
import 'package:clock/clock.dart';
import 'package:typed_result/typed_result.dart';

class TimeRepositoryImpl implements TimeRepository {
  final NtpDataSource ntpDataSource;
  final Clock clock;

  const TimeRepositoryImpl(this.ntpDataSource, this.clock);

  @override
  Future<Result<DateTime, dynamic>> getCurrentTime() async {
    final now = clock.now();
    try {
      final currentOffset = await ntpDataSource.getNtpOffset();
      return Ok(now.add(Duration(milliseconds: currentOffset)));
    } catch (e) {
      return Err(e);
    }
  }
}
