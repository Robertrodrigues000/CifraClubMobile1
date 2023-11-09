import 'package:cifraclub/domain/songbook/use_cases/favorite_unfavorite_version.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_is_favorite_version_by_song_id.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/domain/user/use_cases/run_if_user_is_logged_in.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class HeaderMiddleware extends VersionMiddleware {
  final GetIsFavoriteVersionBySongId _getIsFavoriteVersionBySongId;
  final FavoriteUnfavoriteVersion _favoriteUnfavoriteVersion;
  final RunIfUserIsLoggedIn _openLoginView;

  HeaderMiddleware(this._getIsFavoriteVersionBySongId, this._favoriteUnfavoriteVersion, this._openLoginView);

  CompositeSubscription compositeSubscription = CompositeSubscription();
  var perdingFavorite = false;

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) async {
    switch (action) {
      case OnTapFavoriteButton():
        _openLoginView(
          () async {
            await _favoriteVersion(state, addAction);
          },
          onFail: null,
          openLoginIfUserNotLoggedIn: true,
        );
      case OnVersionLoaded():
        final songId = action.versionData.song.songId;

        if (songId != state.version?.song.songId) {
          await compositeSubscription.clear();

          _getIsFavoriteVersionBySongId(songId).listen((isFavorite) {
            if (!perdingFavorite) {
              addAction(OnFavoriteChange(isFavorite: isFavorite));
            }
            perdingFavorite = false;
          }).addTo(compositeSubscription);
        }
      default:
        break;
    }
  }

  Future<void> _favoriteVersion(VersionState state, ActionEmitter addAction) async {
    if (state.version == null || state.version!.artist == null) {
      return;
    }

    final isFavorite = state.versionHeaderState.isFavorite;

    addAction(OnFavoriteChange(isFavorite: !isFavorite));
    perdingFavorite = true;
    final result = await _favoriteUnfavoriteVersion(
      isFavorite: state.versionHeaderState.isFavorite,
      songId: state.version!.song.songId,
      artistUrl: state.version!.artist!.url,
      songUrl: state.version!.song.url,
    );

    switch (result) {
      case FavoriteVersionSuccess():
      case UnFavoriteVersionSuccess():
        break;
      case FavoriteVersionError():
      case UnFavoriteVersionError():
        perdingFavorite = false;
        addAction(OnFavoriteChange(isFavorite: isFavorite, haveError: result));
    }
  }

  @override
  void close() async {
    await compositeSubscription.cancel();
  }
}
