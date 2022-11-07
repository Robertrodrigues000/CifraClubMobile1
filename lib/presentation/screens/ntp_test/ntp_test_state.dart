abstract class NtpTestState {}

class NtpTestInitialState implements NtpTestState {}

class NtpTestLoadingState implements NtpTestState {}

class NtpTestErrorState implements NtpTestState {}

class NtpTestLoadedState implements NtpTestState {
  final DateTime currentTime;

  const NtpTestLoadedState(this.currentTime);
}
