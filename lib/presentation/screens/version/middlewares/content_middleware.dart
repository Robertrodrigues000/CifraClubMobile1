import 'package:cifraclub/domain/version/use_cases/parse_sections.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContentMiddleware implements VersionMiddleware {
  final ParseSections _parseSections;

  ContentMiddleware(this._parseSections);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is OnVersionLoaded) {
      final sections = _parseSections(action.versionData.content);
      final versionFilters = action.versionData.songsDetail!
          .firstWhere((element) => element.type == state.versionHeaderState.selectedInstrument!.apiType)
          .songs!
          .map((e) => VersionFilter(
                versionName: e.label,
                versionUrl: e.versionUrl,
                isVerified: e.verified,
              ))
          .toList(growable: false);
      final selectedFilter = VersionFilter(
        versionName: action.versionData.label,
        versionUrl: action.versionData.versionUrl,
        isVerified: action.versionData.verified,
      );
      addAction(OnContentParsed(
          sections: sections,
          versionData: action.versionData,
          versionFilters: versionFilters,
          selectedFilter: selectedFilter));
    }
  }
}
