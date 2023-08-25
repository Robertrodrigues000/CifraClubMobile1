import 'package:cifraclub/domain/version/use_cases/parse_sections.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContentMiddleware extends VersionMiddleware {
  final ParseSections _parseSections;

  ContentMiddleware(this._parseSections);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is OnVersionLoaded) {
      // TODO: Verificar cifra autorizada

      final sections = _parseSections(action.versionData.content);
      final versionFilters = action.versionData.instrumentVersions!
          .firstWhereOrNull((element) => element.instrument == action.versionData.instrument)
          ?.versions
          .map(
            (e) => VersionFilter(
              instrument: action.versionData.instrument,
              versionName: e.label,
              versionUrl: e.versionUrl,
              isVerified: e.isVerified,
            ),
          )
          .toList(growable: false);
      final selectedFilter = VersionFilter(
        versionName: action.versionData.versionName,
        versionUrl: action.versionData.versionUrl,
        isVerified: action.versionData.isVerified,
        instrument: action.versionData.instrument,
      );

      if (versionFilters == null) {
        addAction(OnVersionError(error: VersionEmptyError()));
      } else {
        addAction(
          OnContentParsed(
            sections: sections,
            versionData: action.versionData,
            versionFilters: versionFilters,
            selectedFilter: selectedFilter,
          ),
        );
      }
    }
  }
}
