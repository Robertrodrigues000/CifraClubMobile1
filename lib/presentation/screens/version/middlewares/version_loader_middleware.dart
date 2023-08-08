import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';
import 'package:collection/collection.dart';

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
        break;

      case OnVersionSelected():
        final versionData = state.version;
        if (versionData?.artist == null) {
          return;
        }

        final instrumentUrl = Instrument.getInstrumentByType(versionData!.type)?.instrumentUrl;
        if (instrumentUrl == null) {
          logger?.sendNonFatalCrash(exception: Exception("Unknown instrument type: ${versionData.type}"));
          return;
        }

        var versionUrl = versionData.songsDetail
            ?.firstWhere((element) => element.type == state.versionHeaderState.selectedInstrument!.apiType)
            .songs
            ?.firstWhereOrNull(
              (element) => element.label == action.filter.versionName,
            )
            ?.versionUrl;
        if (versionUrl == null) {
          return;
        }

        _fetchVersion(
          addAction,
          versionData.artist!.url,
          versionData.music.url,
          instrumentUrl,
          versionUrl,
        );
        break;
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

    await Future.delayed(const Duration(seconds: 2));
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
        addAction(OnVersionLoadError(error: error));
      },
    );
  }
}
