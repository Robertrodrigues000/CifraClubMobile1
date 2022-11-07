// coverage:ignore-file
import 'package:cifraclub/data/time/data_source/ntp_data_source.dart';
import 'package:cifraclub/data/time/repository/time_repository_impl.dart';
import 'package:cifraclub/domain/time/repository/time_repository.dart';
import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';

@module
abstract class TimeModule {
  NtpDataSource getNtpDataSource() {
    return const NtpDataSource();
  }

  TimeRepository getTimeRepository(NtpDataSource ntpDataSource) {
    return TimeRepositoryImpl(ntpDataSource, const Clock());
  }
}
