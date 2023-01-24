import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

extension MockStream<State> on Cubit<State> {
  /// IMPORTANT: This extension is meant to be used only in mocks
  /// and will not work with real Cubit instances.
  ///
  /// Mocks the stream to push [state] when listened.
  void mockStream(State state) {
    whenListen(this, const Stream.empty(), initialState: state);
    when(() => stream).thenAnswer((_) => Stream.value(state));
  }
}
