// coverage:ignore-file
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Cubit<MainState> {
  MainBloc()
      : super(
          const MainState(),
        );
}
