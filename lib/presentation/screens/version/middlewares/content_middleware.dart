import 'package:cifraclub/domain/section/models/section.dart';
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
  final ProcessSections _processSections;
  final GetAllInstrumentVersions _getAllInstrumentVersions;

  ContentMiddleware(this._parseSections, this._processSections, this._getAllInstrumentVersions);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is OnVersionLoaded) {
      final versionFilters = action.versionData.instrumentVersions!
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
      final selectedFilter = VersionFilter(
        versionName: action.versionData.versionName,
        versionUrl: action.versionData.versionUrl,
        isVerified: action.versionData.isVerified,
        instrument: action.versionData.instrument,
      );

      var versionData = action.versionData;
      versionData = action.versionData
          .copyWith(instrumentVersions: _getAllInstrumentVersions(action.versionData.instrumentVersions ?? []));

      if (versionFilters == null) {
        addAction(OnVersionError(error: VersionEmptyError()));
      } else {
        // TODO: Verificar cifra autorizada

        List<Section> sections = [];
        if (action.versionData.instrument.isCifraInstrument) {
          sections = _parseSections(action.versionData.content);
          // TODO: Mover pra uma Action especializada. Quando trocarmos tamanho de fonte, poderemos só chamar o Process sem Parse.
          _processSections(sections, 40);
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
  }
}
