import 'package:cifraclub/data/time/data_source/ntp_data_source.dart';
import 'package:cifraclub/data/time/repository/time_repository_impl.dart';
import 'package:cifraclub/domain/shared/request_result.dart';
import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _NtpDataSourceMock extends Mock implements NtpDataSource {}

void main() {
  final now = DateTime(2000, 01, 01);
  final mockClock = Clock.fixed(now);

  group("when `getCurrentTime()` is invoked", () {
    test("return the sum of the current time with the data source response", () async {
      const dataSourceResponse = 17;
      final ntpDataSource = _NtpDataSourceMock();
      final repository = TimeRepositoryImpl(ntpDataSource, mockClock);
      when(ntpDataSource.getNtpOffset).thenAnswer((invocation) => SynchronousFuture(dataSourceResponse));

      final response = await repository.getCurrentTime() as RequestResultLoaded;

      expect(response.data, now.add(const Duration(milliseconds: dataSourceResponse)));
    });

    test("return a `RequestResultError` if the dataSource throws an exception", () async {
      final ntpDataSource = _NtpDataSourceMock();
      final repository = TimeRepositoryImpl(ntpDataSource, mockClock);
      when(ntpDataSource.getNtpOffset).thenAnswer((invocation) => throw Exception("error"));

      final response = await repository.getCurrentTime();

      expect(response, isA<RequestResultError>());
    });
  });
}
