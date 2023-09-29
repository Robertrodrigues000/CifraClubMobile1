import 'package:cifraclub/domain/version/use_cases/get_auto_scroll_stream.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class AutoScrollMiddleware implements VersionMiddleware {
  final double _screenDensity;
  final GetAutoScrollStream _getAutoScrollStream;
  final subscriptions = CompositeSubscription();

  AutoScrollMiddleware(@factoryParam this._screenDensity, this._getAutoScrollStream);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) async {
    switch (action) {
      case OnAutoScrollSpeedSelected():
        if (state.autoScrollState.isAutoScrollRunning) {
          _stop();
          _start(speedFactor: action.speedFactor, screenDensity: _screenDensity, addAction: addAction);
        }

      case OnAutoScrollStart():
        _start(speedFactor: state.autoScrollState.speedFactor, screenDensity: _screenDensity, addAction: addAction);
      case OnAutoScrollStop():
        _stop();
      default:
        break;
    }
  }

  void _start({
    required double speedFactor,
    required double screenDensity,
    required ActionEmitter addAction,
  }) {
    assert(subscriptions.isEmpty);
    _getAutoScrollStream(speedFactor: speedFactor, screenDensity: _screenDensity).listen((delta) {
      addAction(OnAutoScrollTickAction(delta));
    }).addTo(subscriptions);
  }

  Future<void> _stop() async {
    await subscriptions.clear();
  }

  @override
  void close() {
    subscriptions.clear();
  }
}
