import 'package:cifraclub/domain/shared/request_result.dart';
import 'package:cifraclub/domain/time/use_cases/get_current_time.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NtpTestBloc extends Cubit<NtpTestState> {
  final GetCurrentTime getCurrentTime;

  NtpTestBloc({required this.getCurrentTime}) : super(NtpTestInitialState());

  Future<void> requireCurrentTime() async {
    if (state is! NtpTestLoadingState) {
      emit(NtpTestLoadingState());
      final result = await getCurrentTime();
      result.when(
        success: (data) {
          emit(NtpTestLoadedState(data));
        },
        error: (RequestResultState requestResultState, dynamic error) {
          emit(NtpTestErrorState());
        },
      );
    }
  }
}
