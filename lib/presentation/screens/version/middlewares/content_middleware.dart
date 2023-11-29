import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/section/use_cases/characters_per_line.dart';
import 'package:cifraclub/domain/section/models/tab_section.dart';
import 'package:cifraclub/domain/section/use_cases/parse_sections.dart';
import 'package:cifraclub/domain/section/use_cases/process_sections.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/use_cases/get_all_instrument_versions.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/models/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContentMiddleware extends VersionMiddleware {
  final ParseSections _parseSections;
  final GetAllInstrumentVersions _getAllInstrumentVersions;
  final ProcessSections _processSections;
  final CharactersPerLine _charactersPerLine;

  ContentMiddleware(
      this._parseSections, this._getAllInstrumentVersions, this._processSections, this._charactersPerLine);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    switch (action) {
      case OnVersionLoaded():
        _loadVersion(action, addAction);
      case OnContentProcess():
        _processContent(state, action, addAction);
      case OnChangeTabsVisibility():
        _setTabsVisibility(state, action, addAction);
      default:
        break;
    }
  }

  void _loadVersion(OnVersionLoaded action, ActionEmitter addAction) {
    final selectedFilter = VersionFilter(
      versionName: action.versionData.versionName,
      versionUrl: action.versionData.versionUrl,
      isVerified: action.versionData.isVerified,
      instrument: action.versionData.instrument,
    );

    var versionData = action.versionData;
    versionData = action.versionData
        .copyWith(instrumentVersions: _getAllInstrumentVersions(action.versionData.instrumentVersions ?? []));

    final versionFilters = versionData.instrumentVersions!
        .firstWhereOrNull((element) => element.instrument == action.versionData.instrument)
        ?.versions
        .map(
          (e) => VersionFilter(
            instrument: action.versionData.instrument,
            versionName: e.versionName,
            versionUrl: e.versionUrl,
            isVerified: e.isVerified,
          ),
        )
        .toList(growable: false);

    if (versionFilters == null || versionFilters.isEmpty) {
      addAction(OnVersionError(error: VersionEmptyError()));
    } else {
      List<Section> sections = [];
      if (action.versionData.instrument.isCifraInstrument) {
        sections = _parseSections(action.versionData.content);
      }

      addAction(
        OnContentParsed(
          sections: sections,
          versionData: versionData,
          versionFilters: versionFilters,
          selectedFilter: selectedFilter,
        ),
      );
    }
  }

  void _processContent(VersionState state, OnContentProcess action, ActionEmitter addAction) {
    if (state.version?.instrument.isCifraInstrument ?? false) {
      final maxChar = _charactersPerLine(
        fontSize: state.fontSizeState.fontSize.toDouble(),
        screenWidth: action.screenWidth,
        screenPadding: action.screenMargin,
      );
      _processSections(state.sections, maxChar);
      addAction(OnContentProcessed(sections: state.sections));
    }
  }

  void _setTabsVisibility(VersionState state, OnChangeTabsVisibility action, ActionEmitter addAction) {
    List<Section> filteredSections =
        action.newVisibility ? state.sections : state.sections.where((e) => e is! TabSection).toList();

    addAction(
      OnTabsVisibilityChanged(filteredSections),
    );
  }
}
