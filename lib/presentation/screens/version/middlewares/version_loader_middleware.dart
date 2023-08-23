import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

typedef ActionEmitter = void Function(VersionAction);

@injectable
class VersionLoaderMiddleware implements VersionMiddleware {
  final GetVersionData _getVersionData;

  VersionLoaderMiddleware(this._getVersionData);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    switch (action) {
      case OnVersionInit():
        if (action.artistUrl != null && action.songUrl != null) {
          _fetchVersion(
            addAction,
            action.artistUrl!,
            action.songUrl!,
          );
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
      artistDns: artistUrl,
      songDns: songUrl,
      instrumentUrl: instrumentUrl,
      versionUrl: versionUrl,
    );

    result.when(
      success: (versionData) {
        addAction(OnVersionLoaded(versionData));
      },
      failure: (error) {
        addAction(OnVersionError(error: VersionLoadError(error)));
      },
    );
  }
}
