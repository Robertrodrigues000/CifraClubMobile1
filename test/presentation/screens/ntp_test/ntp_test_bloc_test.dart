import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_bloc.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _GetCurrentTimeMock extends Mock implements GetCurrentTime {}

void main() {
  test("When `NtpTestBloc` is created, initial state must be `NtpTestInitialState`", () {
    final bloc = NtpTestBloc(getCurrentTime: _GetCurrentTimeMock());
    expect(bloc.state, isA<NtpTestInitialState>());
  });

  group("When requireCurrentTime() is invoked and request is successful", () {
    final currentTime = DateTime(0);
    final getCurrentTime = _GetCurrentTimeMock();

    when(getCurrentTime.call).thenAnswer((invocation) => SynchronousFuture(Ok(currentTime)));

    blocTest(
      "emit a Loading and than a Loaded state",
      build: () => NtpTestBloc(getCurrentTime: getCurrentTime),
      act: (bloc) => bloc.requireCurrentTime(),
      expect: () => [
        isA<NtpTestLoadingState>(),
        predicate((state) => state is NtpTestLoadedState && state.currentTime == currentTime),
      ],
    );
  });

  group("When requireCurrentTime() is invoked and request fails", () {
    final getCurrentTime = _GetCurrentTimeMock();
    when(getCurrentTime.call).thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

    blocTest(
      "emit a Loading and than a Error state",
      build: () => NtpTestBloc(getCurrentTime: getCurrentTime),
      act: (bloc) => bloc.requireCurrentTime(),
      expect: () => [
        isA<NtpTestLoadingState>(),
        isA<NtpTestErrorState>(),
      ],
    );
  });
}
