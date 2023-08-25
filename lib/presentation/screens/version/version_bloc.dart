import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_reducer.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class VersionBloc extends Bloc<VersionAction, VersionState> {
  final List<VersionMiddleware> _middlewares;
  final VersionReducer _reducer;

  final _versionEffectStream = PublishSubject<VersionEffect>();
  Stream<VersionEffect> get versionEffectStream => _versionEffectStream.stream;

  VersionBloc(this._middlewares, this._reducer) : super(const VersionState()) {
    on<VersionAction>(onDispatch);
  }

  void onDispatch(VersionAction action, Emitter<VersionState> emit) {
    for (var middleware in _middlewares) {
      middleware.onAction(action, state, add);
    }

    var newState = _reducer.reduce(state, action, _versionEffectStream.add);
    emit(newState);
  }

  @override
  Future<void> close() {
    _versionEffectStream.close();
    for (var middleware in _middlewares) {
      middleware.close();
    }
    return super.close();
  }
}
