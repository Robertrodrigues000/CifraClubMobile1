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
  double? nextSpeedFactor;

  AutoScrollMiddleware(@factoryParam this._screenDensity, this._getAutoScrollStream);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) async {
    switch (action) {
      case OnAutoScrollSpeedSelected():
        if (state.autoScrollState.isAutoScrollRunning) {
          nextSpeedFactor = action.speedFactor;
        }
      case OnAutoScrollStart():
        _start(speedFactor: state.autoScrollState.speedFactor, addAction: addAction);
      case OnAutoScrollStop():
        _stop();
      default:
        break;
    }
  }

  void _start({required double speedFactor, required ActionEmitter addAction}) {
    assert(subscriptions.isEmpty);
    _getAutoScrollStream(speedFactor: speedFactor, screenDensity: _screenDensity).listen((delta) {
      addAction!(OnAutoScrollTickAction(delta));
      if (nextSpeedFactor != null) {
        _stop();
        _start(speedFactor: nextSpeedFactor!, addAction: addAction);
        nextSpeedFactor = null;
      }
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
