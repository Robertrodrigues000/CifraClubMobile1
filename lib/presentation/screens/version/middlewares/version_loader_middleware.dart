import 'package:cifraclub/domain/version/models/version_status.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class VersionLoaderMiddleware extends VersionMiddleware {
  final GetVersionData _getVersionData;

  VersionLoaderMiddleware(this._getVersionData);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    switch (action) {
      case OnVersionInit():
        if (action.artistUrl != null && action.songUrl != null) {
          if (action.instrument != null && action.versionUrl != null) {
            _fetchVersion(
              addAction,
              action.artistUrl!,
              action.songUrl!,
              action.instrument!.instrumentUrl,
              action.versionUrl!.isNotEmpty ? action.versionUrl : null,
            );
          } else if (action.youtubeId == null) {
            _fetchVersion(
              addAction,
              action.artistUrl!,
              action.songUrl!,
            );
          }
        }

      case OnVersionSelected():
        final versionData = state.version;
        if (versionData?.artist == null) {
          return;
        }

        _fetchVersion(
          addAction,
          versionData!.artist!.url,
          versionData.song.url,
          action.filter.instrument.instrumentUrl,
          action.filter.versionUrl,
        );

      case OnRestoreVersion():
        final versionData = state.version;

        _fetchVersion(
          addAction,
          versionData!.artist!.url,
          versionData.song.url,
          versionData.instrument.instrumentUrl,
          versionData.versionUrl,
        );
      default:
        break;
    }
  }

  Future<void> _fetchVersion(
    ActionEmitter addAction,
    String artistUrl,
    String songUrl, [
    String? instrumentUrl,
    String? versionUrl,
  ]) async {
    addAction(OnStartLoading());

    final result = await _getVersionData(
      artistUrl: artistUrl,
      songUrl: songUrl,
      instrumentUrl: instrumentUrl,
      versionUrl: versionUrl,
    );

    result.when(
      success: (versionData) {
        if (versionData.status != VersionStatus.unauthorized) {
          addAction(OnVersionLoaded(versionData));
        } else {
          addAction(OnVersionError(error: VersionUnauthorizedError(version: versionData)));
        }
      },
      failure: (error) {
        addAction(OnVersionError(error: VersionLoadError(error)));
      },
    );
  }
}
