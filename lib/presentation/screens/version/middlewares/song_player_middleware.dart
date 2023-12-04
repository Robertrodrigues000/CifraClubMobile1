import 'package:cifraclub/domain/song/song_player.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/player_action.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SongPlayerMiddleware extends VersionMiddleware with SubscriptionHolder {
  final SongPlayer _songPlayer;

  SongPlayerMiddleware(this._songPlayer);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) async {
    switch (action) {
      case OnSongSelected():
        await subscriptions.clear();
        await _songPlayer.initPlayer();
        await _songPlayer.setAudio(action.path);

        final duration = await _songPlayer.getAudioDuration();
        if (duration != null) {
          addAction(OnGetSongDuration(duration: duration));
        }

        _songPlayer.positionStream.listen((position) {
          addAction(OnUpdateActualTime(duration: position));
        }).addTo(subscriptions);

        _songPlayer.stateStream.listen((event) {
          addAction(OnSongPlayerStateChanged(event));
        }).addTo(subscriptions);
      case OnSongTimeChanged():
        _songPlayer.changeAudioTime(action.duration);
      case OnPlayerControllerAction():
        switch (action.action) {
          case PlayerAction.pause:
            _songPlayer.pauseAudio();
          case PlayerAction.play:
            _songPlayer.resumeAudio();
          case PlayerAction.cancel:
            addAction(OnGetSongDuration(duration: null));
            _songPlayer.cancel();
            await subscriptions.clear();
          //coverage: ignore-start
          case null:
            break;
          //coverage: ignore-end
        }
      default:
        break;
    }
  }

  @override
  void close() {
    subscriptions.dispose();
    _songPlayer.dispose();
    super.close();
  }
}
